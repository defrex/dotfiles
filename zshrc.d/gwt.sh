# Git worktree management functions

function gwt() {
    if [ -z "$1" ]; then
        echo "Usage: gwt <branch-name>"
        return 1
    fi

    # Convert to lowercase
    local branch_name=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    local project_dir=$(basename "$PWD")
    local parent_dir=$(dirname "$PWD")
    local safe_name="${branch_name//\//-}"
    local worktree_dir="${parent_dir}/${project_dir}-${safe_name}"

    # Check if a worktree already exists for this branch
    local existing_worktree=$(git worktree list --porcelain | grep -A 2 "branch refs/heads/$branch_name" | grep "^worktree " | cut -d' ' -f2)
    if [ -n "$existing_worktree" ]; then
        echo "Worktree already exists for branch '$branch_name' at: $existing_worktree"
        cd "$existing_worktree"
        return 0
    fi

    # Detect default branch (main or master)
    local default_branch="main"
    if ! git rev-parse --verify main >/dev/null 2>&1; then
        if git rev-parse --verify master >/dev/null 2>&1; then
            default_branch="master"
        else
            echo "Error: Neither 'main' nor 'master' branch found"
            return 1
        fi
    fi

    # Check if the branch exists
    if git rev-parse --verify "$branch_name" >/dev/null 2>&1; then
        echo "Branch '$branch_name' already exists, checking it out in new worktree"
        git worktree add "$worktree_dir" "$branch_name"
    else
        echo "Creating new branch '$branch_name' from $default_branch"
        git worktree add -b "$branch_name" "$worktree_dir" "$default_branch"
    fi && \
    if [ -f .env ]; then
        cp .env "$worktree_dir/.env"
        echo "Copied .env to worktree"
    fi && \
    if [ -f .claude/settings.local.json ] && ! git ls-files --error-unmatch .claude/settings.local.json >/dev/null 2>&1; then
        mkdir -p "$worktree_dir/.claude"
        cp .claude/settings.local.json "$worktree_dir/.claude/settings.local.json"
        echo "Copied .claude/settings.local.json to worktree"
    fi && \
    cd "$worktree_dir" && \
    echo -ne "\033]0;${project_dir}-${safe_name}\007" && \
    if [ -f bun.lockb ] || [ -f bun.lock ]; then
        echo "Running bun install..."
        bun install
    elif [ -f package-lock.json ]; then
        echo "Running npm install..."
        npm install
    elif [ -f yarn.lock ]; then
        echo "Running yarn install..."
        yarn install
    fi
}

function gwt-clean() {
    local project_dir=$(basename "$PWD")
    local parent_dir=$(dirname "$PWD")

    # Get all worktrees for this project
    git worktree list --porcelain | grep -E "^worktree " | while read -r line; do
        local worktree_path=$(echo "$line" | cut -d' ' -f2)
        local worktree_name=$(basename "$worktree_path")

        # Skip if not a project worktree or if it's the main worktree
        if [[ "$worktree_name" != "$project_dir-"* ]] || [[ "$worktree_path" == "$PWD" ]]; then
            continue
        fi

        # Get the branch name from the worktree
        local branch_name=$(git -C "$worktree_path" branch --show-current 2>/dev/null)

        if [ -n "$branch_name" ] && [ "$branch_name" != "main" ]; then
            # Check if branch has a merged PR using GitHub CLI
            if command -v gh >/dev/null 2>&1; then
                local pr_state=$(gh pr list --state merged --head "$branch_name" --json state --jq '.[0].state' 2>/dev/null)
                if [ "$pr_state" = "MERGED" ]; then
                    echo "Cleaning up merged worktree: $worktree_name (branch: $branch_name - PR merged)"
                    git worktree remove "$worktree_path" --force
                    git branch -d "$branch_name" 2>/dev/null || true
                else
                    echo "Skipping worktree: $worktree_name (branch: $branch_name - no merged PR found)"
                fi
            else
                echo "Skipping worktree: $worktree_name (branch: $branch_name - GitHub CLI not available)"
            fi
        fi
    done
}

function gwt-rm() {
    if [ -z "$1" ]; then
        echo "Usage: gwt-rm <feature-name>"
        return 1
    fi

    local project_dir=$(basename "$PWD")
    local parent_dir=$(dirname "$PWD")
    local safe_name="${1//\//-}"
    local worktree_dir="${parent_dir}/${project_dir}-${safe_name}"

    if [ -d "$worktree_dir" ]; then
        echo "Removing worktree: $worktree_dir"
        git worktree remove "$worktree_dir" --force

        # Only delete local branch if it has been pushed to remote
        if git ls-remote --heads origin "$1" | grep -q "$1"; then
            echo "Branch $1 exists on remote, deleting local branch"
            git branch -d "$1" 2>/dev/null || true
        else
            echo "Branch $1 not pushed to remote, keeping local branch"
        fi
    else
        echo "Worktree not found: $worktree_dir"
        return 1
    fi
}
