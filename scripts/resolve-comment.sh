#!/bin/bash

# Expected Environment Variables
#         GITLAB_TOKEN | The users GitLab token.
#        CI_PROJECT_ID | The GitLab project id.
# CI_MERGE_REQUEST_IID | The GitLab merge request IID.

# Log In to glab CLI https://gitlab.com/gitlab-org/cli
glab auth login -t $GITLAB_TOKEN
user_id=$(glab api user | jq .id)

resolution_msg="Previous linting failures have been resolved. Resolving this thread!"

# The string to search for in the comment body (this comes from parse-codequality-report.sh)
search_string="Pipeline Failure - Linting Errors"

# Search for previous Linting Error messages by our bot user.
note_id=$(glab api projects/$CI_PROJECT_ID/merge_requests/$CI_MERGE_REQUEST_IID/notes | \
  jq -c "last(.[] | \
    select(.author | .id | contains($user_id)) | \
    select(.body | contains(\"$search_string\"))) | \
    .id")

# If the note already exists, find the discussion and resolve it
if [ $note_id != null ]; then
  echo "Found existing note with id: $note_id"
  glab api projects/$CI_PROJECT_ID/merge_requests/$CI_MERGE_REQUEST_IID/notes/$note_id -X PUT -f body="$resolution_msg"
else
  echo "No previous note found, nothing to do here :)"
fi
