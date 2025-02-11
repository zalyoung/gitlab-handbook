---
title: "Self-hosted Model Fine-tuning"
status: proposed
creation-date: "2025-02-03"
authors: ["@enikon", "@bcardoso-"]
coaches: ["@eduardobonet"]
approvers: [ "@susie.bee" ]
owning-stage: "~devops::ai-powered"
participating-stages: []
toc_hide: true
---

<!-- Design Documents often contain forward-looking statements -->

<!-- This renders the design document header on the detail page, so don't remove it-->

{{< design-document-header >}}

## Summary

This blueprint proposes a solution for fine-tuning Duo Self-hosted models using Parameter-Efficient Fine-Tuning (PEFT). 

## Motivation

With the development of Duo Self-hosted, the need for model customization has arisen. As the first example, customers were dissatisfied with the performance of the supported models on Code Suggestions for some niche coding languages. Another example was the desire for more personalized code suggestions, i.e. feature responses that are more accurate to their requirement and follow the coding patterns of their codebase. One of the possible approaches to customize the model is to finetune it for a specific task or user's codebase.

### Challenges of Model's Fine-tuning

While fine-tuning the entire model is a solution for model customization, it comes with several big challenges:

1) Training a model usually requires roughly 3-4x more vRAM than simply loading the model.
2) Storing _n_ custom fine-tuned models would have high disk usage.
3) Hosting  _n_ different finetuned models simultaneously might be slow and resource expensive.

This, together with the overall expectation that an average customer would be limited in its available hardware resources, motivates us to look into other more efficient approaches.

## Goal

Enable lightweight and efficient model fine-tuning for Gitlab Duo Self-hosted customers.

## Non-goals

Any other forms of customizing the model:

- Full model fine-tuning
- RAG
- RLHF

## Proposal: PEFT and light-weight adapters

One of the possible solutions to achieve lightweight and quick fine-tuning involves using PEFT techniques, such as adapters.

#### What is an adapter?

Adapter-based methods add extra trainable parameters to the existing (base) model's layers. The base model weights stay frozen, while the new additional weights are trained on a new dataset. In the case of Code Suggestions, the dataset could be the customer's codebase or any other suitable data. One of the most widely used adapter-based methods is Low-Rank Adaptation (LoRA). In a nutshell, LoRA uses small rank matrices that are combined with the original model's weights. These small new weights are stored separately and are a magnitude smaller in size than the weights of a base model. During the inference, the new weights are combined with the base model weights, allowing us to simultaneously host one base model and multiple different task-specific LoRAs.

#### Advantages and Limitations

As with any method, the LoRA method comes with its advantages and limitations. _Generally_, LoRA slightly loses against a fully finetuned model in the overall performance, but if time and hardware are the restrictions, then a small performance difference might be okay.

**Advantages:**

1) Training an adapter requires less memory and is much more time-efficient than full-model finetuning
2) The model's size would be in 100s of megabytes rather than 100s of gigabytes.
3) Hosting and switching between different adapters is usually a low-latency procedure

**Limitations:**

1) LoRAs tend to "forget things" a bit more than the fully finetuned model. Thus, we can expect LoRA to perform better than the base model on the task it was trained on, but it could be worse than a base model on the task it was not trained.
2) LoRAs are model-specific, meaning LoRAs can only properly work on the model it was trained on.
3) LoRA is likely to lose in the overall performance and generalization to a fully tuned model.

## Design and Implementation details

### Architecture

#### Inference

```mermaid
flowchart LR
 subgraph s1["vLLM"]
 n1["Base Model"]
 n2["Adapter 1"]
 n3["Adapter 2"]
 n4["Adapter 3"]
 end
    
 subgraph s2["UI"]
 n5["Project 1"]
 n6["Project 2"]
 n7["Project 3-5"]
 n8["Project 6"]
 end

 n1 --> n2
 n1 --> n3
 n1 --> n4
 n2 --> n5
 n2 --> n6
 n3 --> n7
 n4 --> n8

```

#### Training

```mermaid
flowchart LR
 subgraph s2["UI"]
 n5["Project 1"]
 n6["Project 2"]
 n7["Project 3"]
 end
 n8["Data Preparation"]
 n9["Data 1"]
 n10["Data 2"]
 n11["Data 3"]
 n12["Data 2 + 3"]
 n13["Adapter Training"]
 n14["Adapter 1"]
 n15["Adapter 2 + 3"]
 n16["Model Evaluation"]
 n17["Inference"]
 n5 --> n8
 n6 --> n8
 n7 --> n8
 n8 --> n9 & n10 & n11
 n10 --> n12
 n11 --> n12
 n12 --> n13
 n9 --> n13
 n13 --> n15 & n14
 n14 --> n16
 n15 --> n16
 n16 --> n17

 style n5 stroke:#000000
 style n6 stroke:#000000
 style n7 stroke:#000000
 style n8 stroke:#000000
 style n9 stroke:#000000
 style n10 stroke:#000000
 style n11 stroke:#000000
 style n12 stroke:#000000
 style n13 stroke:#000000
 style n15 stroke:#000000
 style n14 stroke:#000000
 style n16 stroke:#000000
 style n17 stroke:#000000
 style s2 stroke:#000000
```

### Data Preparation

Adapters will be trained using customer data, for example, their codebases. To prepare the datasets, customers would need to deploy a local instance of finetuning service on their own infrastructure and provide a path to the repository they wish to use. 

The service then would process the provided by the customer repository, constructing a training and validation dataset out of it.

### Adapter Training

To train an adapter, customers would need to deploy a local instance of finetuning service on their own infrastructure. The finetuning service would be provided using Docker.

The container will be published in the GitLab Container Registry and DockerHub on every GitLab Release.

### Fine-tuned Model Evaluation

Once the adapter is trained, it should be evaluated against a base model in terms of the overall performance and responses. 

To evaluate the model, the customer would be required to deploy the model and its adapters and run an evaluation service. The evaluation service would use a validation dataset to test the base and finetuned models and present the results to the customer.

### Fine-tuned Model Deployment

Once the task-specific adapters are trained, customers would need to host their base model and trained LoRAs using vLLM.

Once hosted, the customer could fetch a specific LoRA by specifying the model's name in the API request to vLLM.

## Technical Details and Early results

### Technical Details

**Storage per Adapter**: 200Mb - 1GB. The size of 1 LoRA adapter could vary based on the configuration.

**Training Time per Adapter**: 30 minutes to 1 hour (Tested on 4xA100 80GB GCP server). Varies based on the size of the training dataset. In the chart below, we present the results for the embedding cosine similarity vs training time. Here "0" minutes represents the base model without any finetuning. Red line is the results for `code_suggestions_aig_signatures` and blue line for `code-suggestions-input-testcases-v1` datasets respectively.


```mermaid
---
config:
    xyChart:
        width: 900
        height: 600
    themeVariables:
        xyChart:
            plotColorPalette: "#ff0000, #0000ff"
---
xychart-beta
    title "Embedding cosine similarity vs Training time"
    x-axis "Time in minutes" [0, 6, 12, 18, 24, 30, 36, 48, 60, 72, 84]
    y-axis "Embedding cosine similarity (higher better)" 0.7 --> 0.95
    line [0.75, 0.80, 0.84, 0.83, 0.85, 0.82, 0.85, 0.83, 0.83, 0.85, 0.84]
    line [0.85, 0.89, 0.91, 0.90, 0.90, 0.90, 0.91, 0.90, 0.90, 0.90, 0.90]
```

While we see the relative performance increase after only 6 minutes, the model is still unstable and requires further training time to reduce the number of empty responses.

```mermaid
---
config:
    xyChart:
        width: 900
        height: 600
    themeVariables:
        xyChart:
            plotColorPalette: "#ff0000, #0000ff"
---
xychart-beta
    title "Bad Responses vs Training time"
    x-axis "Time in minutes" [0, 6, 12, 18, 24, 30, 36, 48, 60, 72, 84]
    y-axis "% of Bad Responses (lower better)" 0.0 --> 0.35
    line [0.0, 0.3, 0.07, 0.06, 0.06, 0.03, 0.0, 0.0, 0.0, 0.0, 0.0]
    line [0.0, 0.27, 0.05, 0.04, 0.04, 0.03, 0.0, 0.0, 0.0, 0.0, 0.0]

```

As a conclusion it seems to be optimal to train the model for 30-40 minutes.

**Hardware Specs for Training an Adapter**: Depending on the selected base model. For Codestral-22B, the minimum spec is 4xA10, while recommended spec is 4xA100 80GB GPUs. In total the current set up uses **242GB** of vRAM.

**Inference Time Impact**: None noticed.

### Early Experimentation (PoC) results

A PoC has been developed for Code Suggestions (code generation and completion) feature. The adapter was trained for [ai-gateway](https://gitlab.com/gitlab-org/modelops/applied-ml/code-suggestions/ai-assist) for Codestral-22B. The finetuned model has shown positive results on both: manual and automated evaluations. 

For **manual** evaluations, the model has been deployed and tested with Duo Self-hosted in WebIDE. The finetuned model proposed code suggestions that are more aligned with the overall code structure, than vanilla Codestral-22B:

[Results for manual evaluations in WebIDE](https://gitlab.com/gitlab-org/gitlab/-/issues/505598#note_2284037077)
and [code completion results](https://gitlab.com/gitlab-org/gitlab/-/issues/505598#note_2285961471)

In addition to the manual evaluations, the finetuned model was evaluated on several datasets where it also showed positive results (i.e. code suggestions were more aligned with existing code). 

[Results for Code Completion using ELI5](https://gitlab.com/gitlab-org/gitlab/-/issues/508867#note_2290318225)

In the table below we present the results of evaluating the finetune model and base model on three different datasets on a code completion task.

In the columns, the two numbers are: embedding similarity, exact match. Higher number is better (meaning results were more similar to the expected output).

| Model | code-suggestions-input-testcases-v1 | code_suggestions_aig_random_fim | code_suggestions_aig_signatures |
| ------ | ------ | ------ | ------ |
| Codestral-22B | 0.89, 0.03 | 0.84, 0.0 | 0.80, 0.0 |
| LoRA+Codestral-22B | **0.91**, **0.17** | **0.87**, 0.0 | **0.85**, **0.05** | 

## Alternatives

Adapters, and in particular, LoRAs are not a panacea, it is one of the methods that we could utilize if find it suitable for our use cases. Other potential approaches are:

1) Full finetuning of a smaller model
2) Human-feedback (RLHF)

**Smaller experts.**
Finetuning a smaller model might be a suitable approach, as the time and hardware resources to train such a model are better than a model with a high number of parameters. However, the scalability of such an approach is questionable, as well as the overall performance of a smaller model.

**Reinforcement Learning from Human Feedback (RLHF).**
Human feedback could be used together with reinforcement learning (RLHF) to further fine-tune the model to the user's needs. For example, whether a suggestion was accepted or rejected can serve as valuable domain-specific feedback data to then further customize the model's fine-tuning process.
