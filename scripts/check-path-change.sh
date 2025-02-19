#!/bin/bash

# Expected Environment Varaibles
#         GITLAB_TOKEN | The users GitLab token.
#        CI_PROJECT_ID | The GitLab project id.
# CI_MERGE_REQUEST_IID | The GitLab merge request IID.

# Log In to glab CLI https://gitlab.com/gitlab-org/cli
export GITLAB_TOKEN="$TRIAGE_TOKEN"
GITLAB_TOKEN="$TRIAGE_TOKEN" glab auth login --stdin < <(echo "$TRIAGE_TOKEN")
user_id=$(GITLAB_TOKEN="$TRIAGE_TOKEN" glab api user | jq .id)

# Search for any existing notes by our bot user.
note_id=`glab api projects/$CI_PROJECT_ID/merge_requests/$CI_MERGE_REQUEST_IID/notes | jq -c "last(.[] | select( .author | .id | contains($user_id))) | .id"`

# If the note already exists, do nothing.
if [ -n "$note_id" ] && [ "$note_id" != "null" ]; then
  echo "Found existing note with id: $note_id"
  echo "Do nothing."
else
  RENAMED_OR_DELETED=$(git diff --name-status --diff-filter=DR origin/${CI_MERGE_REQUEST_TARGET_BRANCH_NAME}...${CI_COMMIT_SHA} | grep '\.md$' || true)
  echo "Checking for renamed or deleted files..."
  if [ -n "$RENAMED_OR_DELETED" ]; then
    echo "Creating new note with request..."
    # Convert comma-separated list to array
    IFS=',' read -ra ASSIGNEES <<< "$CI_MERGE_REQUEST_ASSIGNEES"
    # Create mentions string
    MENTIONS=""
    for assignee in "${ASSIGNEES[@]}"; do
        MENTIONS+="@$assignee "
    done
    glab mr update $CI_MERGE_REQUEST_IID -l "skip-path-check"
    COMMENT="${MENTIONS} this merge request renames or deletes pages.<br /><br />Please ensure that [all links to these files are updated](https://handbook.gitlab.com/handbook/about/editing-handbook/#moving-deleting-or-renaming-a-page) accordingly in the **public and internal handbook**. Optionally, [add a redirect](https://handbook.gitlab.com/docs/development/#redirects)."
    glab mr note --unique $CI_MERGE_REQUEST_IID -m "$COMMENT"
  else
    echo "No renamed or deleted files found."
  fi
fi
