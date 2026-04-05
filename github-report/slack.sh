#!/bin/bash

SINCE=$(date -u -v-${HOURS:-24}H +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || date -u -d "${HOURS:-24} hours ago" +"%Y-%m-%dT%H:%M:%SZ")
QUERY="updated:>=$SINCE $Q"

curl -s -X POST "https://slack.com/api/chat.postMessage" \
  -H "Authorization: Bearer $SLACK_BOT_TOKEN" \
  -H "Content-type: application/json; charset=utf-8" \
  --data "$(jq -n --arg channel "$SLACK_CHANNEL_ID" --arg text "since: $SINCE, query: $QUERY, repos: $REPOS" '{channel: $channel, text: $text}')" >/dev/null

IFS=','
for REPO in $REPOS; do
  REPO=$(echo $REPO | tr -d ' ')

  ISSUES_RAW=$(gh issue list -R "$REPO" --search "$QUERY" --json "number,title,url,createdAt,updatedAt,closedAt,state,labels,author" --limit 1000)
  ISSUE_TEXT=$(echo "$ISSUES_RAW" | jq -r --arg SINCE "$SINCE" '
    flatten | if length == 0 then "  (No activities)" else
      map(
        if (.closedAt != null and .closedAt >= $SINCE) then .status = "1. Closed"
        elif (.createdAt >= $SINCE) then .status = "2. Created"
        else .status = "3. Updated" end
      ) | group_by(.status) | sort_by(.[0].status) | .[] | (sort_by(.updatedAt) | reverse) |
      "\n*\(.[0].status):*",
      (.[] | "• <\(.url)|#\(.number) \(.title)> (`\(.updatedAt)`) `\(.author.login)` [\(.labels | map("`" + .name + "`") | join(", "))]")
    end
  ')

  PRS_RAW=$(gh pr list -R "$REPO" --search "$QUERY" --json "number,title,url,createdAt,updatedAt,closedAt,mergedAt,state,labels,author" --limit 1000)
  PR_TEXT=$(echo "$PRS_RAW" | jq -r --arg SINCE "$SINCE" '
    flatten | if length == 0 then "  (No activities)" else
      map(
        if (.mergedAt != null and .mergedAt >= $SINCE) then .status = "Merged"
        elif (.closedAt != null and .closedAt >= $SINCE) then .status = "Closed"
        elif (.createdAt >= $SINCE) then .status = "Created"
        else .status = "Updated" end
      ) | group_by(.status) | sort_by(.[0].status) | .[] | (sort_by(.updatedAt) | reverse) |
      "\n*\(.[0].status):*",
      (.[] | "• <\(.url)|#\(.number) \(.title)> (`\(.updatedAt)`) `\(.author.login)` [\(.labels | map("`" + .name + "`") | join(", "))]")
    end
  ')

  FULL_TEXT="*Repository: $REPO* (Since: $SINCE)

  *--- Issues ---*
  $ISSUE_TEXT

  *--- Pull Requests ---*
  $PR_TEXT"

  curl -s -X POST "https://slack.com/api/chat.postMessage" \
    -H "Authorization: Bearer $SLACK_BOT_TOKEN" \
    -H "Content-type: application/json; charset=utf-8" \
    --data "$(jq -n --arg channel "$SLACK_CHANNEL_ID" --arg text "$FULL_TEXT" '{channel: $channel, text: $text}')" >/dev/null

done
