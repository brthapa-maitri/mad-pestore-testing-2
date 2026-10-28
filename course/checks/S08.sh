#!/usr/bin/env bash
# S08 Deploy: the URL deploy.sh recorded answers /health with 200 and passes the reference E2E.
set -euo pipefail
source "$(dirname "$0")/../lib/common.sh"

if deployment_local "$COURSE_ROOT/docs/ARCHITECTURE.md"; then note "local only: no cloud deploy"; finish S08; exit 0; fi

urlf="$COURSE_ROOT/.deploy/url"
if [ ! -s "$urlf" ]; then
  fail "no .deploy/url: run scripts/deploy.sh (it records the URL)"
  finish S08 || exit 1
fi
url=$(head -1 "$urlf" | tr -d '[:space:]'); url=${url%/}
code=$(curl -s -o /dev/null -w '%{http_code}' --max-time 15 "$url/health" || true)
[ "$code" = 200 ] || fail "$url/health returned ${code:-no answer}, expected 200"
mkdir -p "$CHECKS_DIR"
if "$COURSE_ROOT/tests/e2e-reference/run.sh" "$url" > "$CHECKS_DIR/S08-e2e.log" 2>&1; then
  note "reference E2E green against $url"
else
  fail "reference E2E failed against $url: see progress/checks/S08-e2e.log"
fi
finish S08
