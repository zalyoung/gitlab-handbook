#!/bin/bash

# Script Arguments
MSG=$1

# Expected Environment Variables
#         GITLAB_TOKEN | The users GitLab token.
#        CI_PROJECT_ID | The GitLab project id.
# CI_MERGE_REQUEST_IID | The GitLab merge request IID.

# Log In to glab CLI https://gitlab.com/gitlab-org/cli
glab auth login -t $GITLAB_TOKEN
user_id=$(glab api user | jq .id)
echo "User ID: $user_id"

# Search for any existing notes by our bot user.
note_id=$(glab api projects/$CI_PROJECT_ID/merge_requests/$CI_MERGE_REQUEST_IID/notes | jq -c "last(.[] | select( .author | .id | contains($user_id))) | .id")

# note: temp workaround for https://gitlab.com/gitlab-com/content-sites/handbook/-/issues/461
if [[ $GITLAB_USER_LOGIN =~ /^(project|group)_/ ]]; then
  echo "Skipping for project or group bot token authored MRs."
  echo "See https://gitlab.com/gitlab-com/content-sites/handbook/-/issues/461"
  exit 0
fi

# If the note already exists, update the message to reduce MR notes.
if [ $note_id != null ]; then
  echo "Found existing note with id: $note_id"
  glab api projects/$CI_PROJECT_ID/merge_requests/$CI_MERGE_REQUEST_IID/notes/$note_id -X PUT -f body="$MSG"
else
  echo "Creating new note with violations..."
  glab mr note --unique $CI_MERGE_REQUEST_IID -m "$MSG"
fi
