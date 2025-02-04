---
title: "Self-hosted Model Fine-tuning"
status: ongoing
creation-date: "2025-02-03"
authors: ["@enikon", "@bcardoso-"]
coaches: ["@eduardobonet"]
dris: [""]
owning-stage: "~devops::ai-powered"
participating-stages: []
toc_hide: true
---

<!-- Design Documents often contain forward-looking statements -->

<!-- This renders the design document header on the detail page, so don't remove it-->

{{< design-document-header >}}

## Summary

This blueprint proposes a solution for customizing Duo Self-hosted models using Parameter-Efficient Fine-Tuning (PEFT). 


## Motivation

With development of Duo Self-hosted, the need for model's customization has arrised. As the first example, customers were dissatisfied with the performance of the supported models on Code Suggestions for some of the niche coding languages. Another example, was the desire for more personalized code suggestions, i.e. feature responses that are more accurate to their requirement and follow the coding patterns of their codebase. One of the possible approaches to customize the model is to finetune it for a specific task or user's codebase.

### Challenges of Model's Customization

While fine-tuning the entire model is one of obvious solutions for model's customization, it comes with several big challenges:

1) Training a model usually requires roughly 3-4x more vRAM than simply loading the model.
2) Storing _n_ custom fine-tuned models would have high disk usage.
3) Hosting  _n_ different finetuned models simultanously might be slow and resource expensive.

This, together with the overall expectation that an average customer would be limited in its available hardware resources, motivates us to look into other more efficient approaches.

## Proposal

In this section we propose a solution that addresses the challenges presented in the section above.

### PEFT and light-weight adapters

One of the possible solutions to achieve a light-weight and quick finetuning are PEFT techniques, such as adapters.

#### What is an adapter?

Adapter-based methods add extra trainable parameters to the existing (base) model's layers. The base model weights stay frozen, while the new additional weights are trained on a new dataset. In the case of Code Suggestions, the dataset could be the customer's codebase or any other suitable data. One of the most widely used adapter-based methods is Low-Rank Adaptation (LoRA). In a nutshell, LoRA uses small rank matrices that are combined with the original model's weights. These small new weights are stored separately and are magnitude smaller in size than the weights of a base model. During the inference, the new weights are combined with the base model weights, allowing us to simultaneously host 1 base model and multiple different task-specific LoRAs.

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

## Goal

Enable light-weight and efficient model's customization for Gitlab Duo Self-hosted customers.

## Non-goals

Any other forms of customizing the model:

- Full model fine-tuning
- RAG
- RLHF

## Design and Implementation details

### Architecture

![Inference with Adapters](/static/images/engineering/architecture/design-documents/self_hosted_finetuning/arch_inference.png)

### Dataset Preparation
Adapters will be trained using customer's data, for example their codebases. To prepare the datasets, customers would need to deploy a local instance of finetuning service on their own infrastructure and provide a path to the repository they wish to use. 

The service then would process the provided by the customer repository, constructing a training and validation dataset out of it.

### Training an Adapter
To train an adapter, customers would need to deploy a local instance of finetuning service on their own infrastructure. The finetuning service would be provided using Docker.

The container will be published to GitLab Container Registry and DockerHub on every GitLab Release.

### Fine-tuned Model Deployment
Once the task-specific adapters are trained, customers would need to host their base model and trained LoRAs using vLLM.

Once hosted, customer could fetch a specific LoRA by specifying the model's name in the API request to vLLM.

### Fine-tuned Model Evaluation
Once the adapter is trained, it should be evaluated against a base model in terms of the overall performance and responses. 

To evaluate the model, customer would be required to deploy the model and its adapters and run evaluation service. The evaluation service would use validation dataset to test the base and finetuned models and present the results to the customer.

## Alternatives

Adapters, and in particular, LoRAs are not a panacea, it is one of the methods that we could utilize if find it suitable for our use cases. Other potential approaches are:

1) Full finetuning of a smaller model
2) RAG
3) Human-feedback (RLHF)

**Smaller experts.**
Finetuning a smaller model might be a suitable approach, as the time and hardware resources to train such model are better than a model with high number of parameters. However, the scalability of such approach is questionable, as well as the overall performance of a smaller model.

**RAG.**
RAG is another popular approach that allows the model to stay up to date-with the ever-changing codebase. In the future, it would be fruitful to explore RAG and finetuning as a combined solution.

**Human-feedback (RLHF).**
Human feedback could be used together with reinforcement learning (RLHF) to tune the model to user's need. For example, was this suggestion accepted or not? This is a type of feedback we could utilize here.


## Future evolution

TODO
