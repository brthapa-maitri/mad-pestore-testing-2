#!/usr/bin/env bash
# S02 Architecture: docs/ARCHITECTURE.md has a Deployment decision (local only, or a cloud and region), no credentials; stack standards generated.
set -euo pipefail
source "$(dirname "$0")/../lib/common.sh"

arch="$COURSE_ROOT/docs/ARCHITECTURE.md"
if [ ! -f "$arch" ]; then
  fail "docs/ARCHITECTURE.md missing: run /mad-plan (Phase 0 writes it)"
  finish S02 || exit 1
fi
deploy=$(deployment_section "$arch")
cloud=$(deployment_cloud "$arch")
if [ -z "$deploy" ]; then fail "ARCHITECTURE.md has no '### Deployment' decision"
elif deployment_local "$arch"; then note "local only (recommended)"
elif [ -z "$cloud" ]; then fail "the Deployment decision is neither 'None (local only)' nor a cloud (aws, azure or gcp)"
else grep -qi region <<<"$deploy" || fail "the Deployment decision records no region"; fi
if grep -qE 'AKIA[0-9A-Z]{16}|aws_secret_access_key|-----BEGIN [A-Z ]*PRIVATE KEY' "$arch"; then
  fail "ARCHITECTURE.md contains what looks like a credential: remove it"
fi
sk="$COURSE_ROOT/.claude/skills"
[ -f "$sk/mad-backend-standards/SKILL.md" ] || [ -f "$sk/mad-frontend-standards/SKILL.md" ] || fail "no stack standards: accept /create-project-overlay in Phase 0"
[ -z "$cloud" ] || note "cloud: $cloud"
finish S02
