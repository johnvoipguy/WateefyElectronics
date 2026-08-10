#!/usr/bin/env bash
set -euo pipefail

OWNER="johnvoipguy"
REPO="WateefyElectronics"

# Requires: gh auth login
# Run: bash create-labels.sh

create_or_update_label () {
  local name="$1"
  local color="$2"
  local desc="$3"

  if gh label list -R "$OWNER/$REPO" --limit 500 --json name --jq '.[].name' | grep -Fxq "$name"; then
    gh label edit "$name" -R "$OWNER/$REPO" --color "$color" --description "$desc" >/dev/null
    echo "Updated: $name"
  else
    gh label create "$name" -R "$OWNER/$REPO" --color "$color" --description "$desc" >/dev/null
    echo "Created: $name"
  fi
}

create_or_update_label "bug" "d73a4a" "Something isn't working"
create_or_update_label "enhancement" "a2eeef" "New feature or request"
create_or_update_label "question" "d876e3" "Further information is requested"
create_or_update_label "test-report" "1d76db" "Structured model/test/result report"
create_or_update_label "hardware" "fbca04" "Board, electrical, or mechanical topic"
create_or_update_label "firmware" "0e8a16" "Firmware behavior or configuration"
create_or_update_label "documentation" "0075ca" "Documentation changes needed"
create_or_update_label "safety" "b60205" "Safety or risk concern"
create_or_update_label "needs-repro" "f9d0c4" "Needs reproducible steps"
create_or_update_label "needs-info" "ededed" "More information required"
create_or_update_label "duplicate" "cfd3d7" "This issue or pull request already exists"
create_or_update_label "wontfix" "ffffff" "This will not be worked on"
create_or_update_label "good first issue" "7057ff" "Good for newcomers"
create_or_update_label "help wanted" "008672" "Extra attention is needed"
create_or_update_label "priority:high" "b60205" "High priority"
create_or_update_label "priority:medium" "fbca04" "Medium priority"
create_or_update_label "priority:low" "0e8a16" "Low priority"

echo "Done."