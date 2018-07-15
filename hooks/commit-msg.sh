#!/bin/sh

COMMIT_FILE=$1
COMMIT_MSG=$(cat $1)
 
JIRA_PRESENT=$(echo "$COMMIT_MSG" | awk '{print $1;}' | awk '{print toupper($0)}' | grep -Eo "[A-Z0-9]{1,10}-?[A-Z0-9]+-\d+")
if [ ! -z "$JIRA_PRESENT" ]; then
  exit 0;
fi

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
JIRA_ID=$(echo "$CURRENT_BRANCH" | awk '{print toupper($0)}' | grep -Eo "[A-Z0-9]{1,10}-?[A-Z0-9]+-\d+")

if [ ! -z "$JIRA_ID" ]; then
    echo "$JIRA_ID $COMMIT_MSG" > $COMMIT_FILE
fi