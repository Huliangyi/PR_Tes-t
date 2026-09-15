#!/bin/bash
# Loop task: for each iteration, create a small Java test file and commit it.
# Continue to the next iteration only after the commit succeeds.
set -euo pipefail

DIR="test_files"
mkdir -p "$DIR"

for i in $(seq 1 3000); do
    name=$(printf "Test%04d" "$i")
    file="$DIR/${name}.java"
    # Skip iterations whose file is already committed (resume support).
    if git cat-file -e "HEAD:$file" >/dev/null 2>&1; then
        continue
    fi
    cat > "$file" <<EOF
public class ${name} {
    public static void main(String[] args) {
        System.out.println("test ${i}");
    }
}
EOF
    git add "$file"
    msg="Add test file ${name}

Co-Authored-By: AtomCode (deepseek-v4-flash) <noreply@atomgit.com>"
    git commit -m "$msg" >/dev/null
    if (( i % 100 == 0 )); then
        echo "progress: ${i}/3000"
    fi
done

echo "LOOP_DONE total_commits=$(git rev-list --count HEAD)"
