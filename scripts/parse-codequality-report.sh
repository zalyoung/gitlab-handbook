#!/bin/bash
MREPORT=markdownlint-cli2-codequality.json
VREPORT=vale-codequality.json
HREPORT=handbook-codequality.json
LREPORT=new_broken_links.json
ERRORS=()
MSG=""
REPO_URL="https://gitlab.com/gitlab-com/content-sites/handbook"

generate_message() {
    MSG+="## ⚠️ Pipeline Failure - Linting Errors\n\n"
    MSG+="One of the linters has reported errors and as a result the pipeline has failed.  Once the pipeline completes, you'll find the code quality report above which can link you to where the error is in your code.  Additionally, below you'll find a table of the errors.  The table has links to the lint rules so you can find more information on how to fix the issue(s).\n\n"
    generate_table
    generate_addition_messages
    MSG+="If you need more help please reach out on Slack in [#mr-buddies](https://gitlab.slack.com/archives/CLM8K5LF4)."
}

generate_table() {
    MSG+="| Rule | File | Line | Error |\n"
    MSG+="|------|------|------|-------|\n"

    LENGTH=$(jq '. | length' $MREPORT)
    for i in $(seq 0 $((LENGTH-1))); do
      ERROR=$(jq -r ".[$i].check_name" $MREPORT | cut -d '/' -f 1)
      URL="https://github.com/DavidAnson/markdownlint/blob/main/doc/Rules.md#$ERROR"
      FILE=$(jq -r ".[$i].location.path" $MREPORT)
      LINE=$(jq -r ".[$i].location.lines.begin" $MREPORT)
      LOC="$REPO_URL/-/blob/$CI_COMMIT_SHA/$FILE#L$LINE"
      DESCRIPTION=$(jq -r ".[$i].description" $MREPORT | cut -d ':' -f 2-)
      ERRORS+=( $ERROR )
      if [[ "$ERROR" ]]; then
        if [[ -z "$URL" ]]; then
          MSG+="| $ERROR | [$FILE]($LOC) | [$LINE]($LOC) | $DESCRIPTION |\n"
        else
          MSG+="| [$ERROR]($URL) | [$FILE]($LOC) | [$LINE]($LOC) | $DESCRIPTION |\n"
        fi
      fi
    done

    LENGTH=$(jq '. | length' $VREPORT)
    for i in $(seq 0 $((LENGTH-1))); do
      if [[ $(jq -r ".[$i].severity" $VREPORT) == "blocker" ]]; then
        ERROR=$(jq -r ".[$i].rule" $VREPORT)
        URL=$(jq -r ".[$i].link" $VREPORT)
        FILE=$(jq -r ".[$i].location.path" $VREPORT)
        LINE=$(jq -r ".[$i].location.lines.begin" $VREPORT)
        LOC="$REPO_URL/-/blob/$CI_COMMIT_SHA/$FILE#L$LINE"
        DESCRIPTION=$(jq -r ".[$i].description" $VREPORT | cut -d ':' -f 2-)
        ERRORS+=( $ERROR )
        if [[ "$ERROR" ]]; then
          if [[ -z "$URL" ]]; then
              MSG+="| $ERROR | [$FILE]($LOC) | [$LINE]($LOC) | $DESCRIPTION |\n"
          else
              MSG+="| [$ERROR]($URL) | [$FILE]($LOC) | [$LINE]($LOC) | $DESCRIPTION |\n"
          fi
        fi
      fi
    done

    LENGTH=$(jq '. | length' $HREPORT)
    for i in $(seq 0 $((LENGTH-1))); do
      ERROR=$(jq -r ".[$i].check_name" $HREPORT | cut -d '/' -f 1)
      URL=$(jq -r ".[$i].link" $HREPORT)
      FILE=$(jq -r ".[$i].location.path" $HREPORT)
      LINE=$(jq -r ".[$i].location.lines.begin" $HREPORT)
      LOC="$REPO_URL/-/blob/$CI_COMMIT_SHA/$FILE#L$LINE"
      DESCRIPTION=$(jq -r ".[$i].description" $HREPORT | cut -d ':' -f 2-)
      ERRORS+=( $ERROR )
      if [[ "$ERROR" ]]; then
          if [[ -z "$URL" ]]; then
              MSG+="| $ERROR | [$FILE]($LOC) | [$LINE]($LOC) | $DESCRIPTION |\n"
          else
              MSG+="| [$ERROR]($URL) | [$FILE]($LOC) | [$LINE]($LOC) | $DESCRIPTION |\n"
          fi
      fi
    done

    # Process linkcheck report
    LENGTH=$(jq '. | length' $LREPORT)
    for i in $(seq 0 $((LENGTH-1))); do
      ERROR=$(jq -r ".[$i].check_name" $LREPORT | cut -d '/' -f 1)
      URL="https://handbook.gitlab.com/handbook/about/editing-handbook/#link-and-anchor-errors"
      FILE=$(jq -r ".[$i].location.path" $LREPORT)
      LINE=$(jq -r ".[$i].location.lines.begin" $LREPORT)
      LOC="$REPO_URL/-/blob/$CI_COMMIT_SHA/$FILE#L$LINE"
      DESCRIPTION=$(jq -r ".[$i].description" $LREPORT | cut -d ':' -f 2-)
      ERRORS+=( $ERROR )
      if [[ "$ERROR" ]]; then
        MSG+="| [Broken link ($ERROR)]($URL) | [$FILE]($LOC) | [$LINE]($LOC) | $DESCRIPTION |\n"
      fi
    done

    MSG+="\n"
}

generate_addition_messages() {
    eval ERRORS=($(printf "%q\n" "${ERRORS[@]}" | sort -u))
    for e in ${ERRORS[@]}; do
        case $e in
            MD009)          MSG+="> 🛑 You have a trailing spaces error.  The [practical handbook edits handbook](https://handbook.gitlab.com/handbook/practical-handbook-edits/) provides more tips, for example [removing trailing whitespaces](https://handbook.gitlab.com/handbook/practical-handbook-edits/#remove-trailing-whitespaces-in-a-merge-request).\n\n"
            ;;
            CODEOWNER)      MSG+="> 🛑 You have marked a handbook page as a controlled document without adding an entry to the controlled-documents section of CODEOWNERS.\n\n"
        esac
    done
}

# Create an array of the report variables
reports=("$MREPORT" "$VREPORT" "$HREPORT" "$LREPORT")
# Initialize an array to store non-empty files
non_empty_files=()

# Check each report file exists and is not empty
for report in "${reports[@]}"; do
    if [ -f "$report" ] && [ "$(jq 'length > 0' "$report")" = "true" ]; then
        non_empty_files+=("$report")
    fi
done

# Print the list of non-empty files
if [ ${#non_empty_files[@]} -gt 0 ]; then
    echo "Using combined codequality.json: "
    for file in "${non_empty_files[@]}"; do
        echo "$file "
    done
    jq -s '.[0] + .[1] + .[2]' "${existing_reports[@]}" > codequality.json
    REPORT=codequality.json
else
    echo "All report files are empty."
fi

# Error handling for JSON parsing
if ! jq '.' $REPORT > /dev/null; then
    echo "Error: Unable to parse JSON report file. Please post in the [#handbook Slack channel](https://gitlab.enterprise.slack.com/archives/C81PT2ALD) for assistance. Exiting..."
    exit 1
fi

generate_message
echo -e $MSG
