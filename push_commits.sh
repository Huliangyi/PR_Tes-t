#!/bin/bash
# Push pending commits to the remote ONE AT A TIME, logging progress as i/3000.
# Continue to the next push only after the previous one succeeds.
# Optional arg: START index (1-based) for resuming after a failure.
set -euo pipefail

START="${1:-1}"

# Fixed base: the last commit before the 3000 loop commits (6befebd).
BASE=6befebd27557a70c87cf22158432d5a7b268268c
SHAS=()
while IFS= read -r sha; do
    SHAS+=("$sha")
done < <(git rev-list --reverse "${BASE}..HEAD")
TOTAL=${#SHAS[@]}

echo "base=${BASE} pending=${TOTAL} start=${START}"

if [ "$TOTAL" -eq 0 ]; then
    echo "PUSH_DONE nothing to push"
    exit 0
fi

for idx in $(seq "$START" "$TOTAL"); do
    i=$((idx - 1))
    sha="${SHAS[$i]}"
    attempt=0
    ok=0
    while [ "$ok" -eq 0 ] && [ "$attempt" -lt 3 ]; do
        if git push origin "${sha}:refs/heads/master" >/dev/null 2>&1; then
            ok=1
        else
            attempt=$((attempt + 1))
            echo "retry ${idx}/${TOTAL} attempt=${attempt} sha=${sha}"
            sleep 5
        fi
    done
    if [ "$ok" -eq 0 ]; then
        echo "FAILED at ${idx}/${TOTAL} sha=${sha}"
        exit 1
    fi
    echo "${idx}/${TOTAL} ${sha}"
done

REMOTE=$(git ls-remote origin refs/heads/master | cut -f1)
LOCAL=$(git rev-parse HEAD)
echo "PUSH_DONE local=${LOCAL} remote=${REMOTE}"
