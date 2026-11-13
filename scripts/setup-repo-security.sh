#!/usr/bin/env bash
# Usage: ./scripts/setup-repo-security.sh OWNER/REPO   (needs: gh auth login, admin on the repo)
set -euo pipefail
REPO="${1:?usage: $0 OWNER/REPO}"

echo "1) Secret scanning + push protection"
gh api -X PATCH "repos/$REPO" --input - <<JSON
{"security_and_analysis":{
  "secret_scanning":{"status":"enabled"},
  "secret_scanning_push_protection":{"status":"enabled"}}}
JSON

echo "2) Dependabot alerts + security updates"
gh api -X PUT "repos/$REPO/vulnerability-alerts"
gh api -X PUT "repos/$REPO/automated-security-fixes"

echo "3) Require actions pinned to full commit SHA (best effort)"
gh api -X PUT "repos/$REPO/actions/permissions" \
  -F enabled=true -f allowed_actions=all -F sha_pinning_required=true \
  || echo "   -> set manually: Settings > Actions > General > 'Require actions to be pinned to a full-length commit SHA'"

echo "4) Default GITHUB_TOKEN to read-only"
gh api -X PUT "repos/$REPO/actions/permissions/workflow" \
  -f default_workflow_permissions=read -F can_approve_pull_request_reviews=false

echo "5) Ruleset on main"
gh api -X POST "repos/$REPO/rulesets" --input ruleset.json

echo "Done. Enable CodeQL 'Code scanning' needs no setup: the workflow uploads results."
