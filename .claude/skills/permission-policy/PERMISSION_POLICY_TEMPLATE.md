# Permission Policy

This file defines the permission policy for the Claude Code permission hook.
Edit this file to customize which tool invocations are auto-approved, denied,
or deferred to the human.

> This policy covers the following tools: Bash, Read, Write, Edit, Glob,
> Grep, WebFetch, WebSearch.

## ALLOW

These operations are safe and should be auto-approved:

### Bash
- Safe dev commands: lint, typecheck, test, build, format (bun run lint, bun
  run typecheck, bun test, etc.)
- Git read-only commands (git status, git log, git diff, git branch, git
  show, git remote -v)
- Standard git workflow (git add, git commit, git push, git pull, git fetch,
  git checkout, git merge, git rebase)
- Package manager operations (bun install, bun add, npm install, yarn add, etc.)
- Running project scripts defined in package.json
- GitHub CLI commands (gh pr view, gh pr list, gh pr create, gh issue view, etc.)
- Creating directories within the project (mkdir)
- Shell reads: ls, cat, head, tail, find, tree
- Docker compose commands for local dev (docker-compose up, docker-compose down)

### Read
- Reading any file within the project directory
- Reading files under the .claude/ directory

### Write
- Writing files within the project directory
- Writing files under the .claude/ directory

### Edit
- Editing any file within the project directory
- Editing files under the .claude/ directory

### Glob
- Searching for files within the project directory

### Grep
- Searching file contents within the project directory

### WebFetch
- Fetching documentation, API references, and well-known developer resources

### WebSearch
- Searching for documentation, error messages, and development-related topics

## ASK

These operations should defer to the human for approval:

### Bash
- Destructive git operations on main/master (git push --force main, git
  reset --hard on main)
- Network exfiltration: curl/wget/ssh/scp to unknown or suspicious hosts
  (allow curl to localhost and well-known dev APIs)
- System configuration modification (/etc/*, system preferences, global
  config files)
- sudo or any root-privilege escalation
- Broad destructive deletion (rm -rf /, rm -rf ~, rm -rf with very broad
  paths)
- Installing global packages or modifying global tool configs
- Running unknown binaries from the internet
- Environment variable exfiltration to external services
- Killing system processes unrelated to the project

### Read
- Reading files outside the project directory
- Reading sensitive credential files (.env, private keys, tokens)

### Write
- Writing files outside the project directory
- Overwriting critical config files (package.json root fields, CI/CD configs)

### Edit
- Editing files outside the project directory
- Editing critical config files that could break the build or deployment

### Glob
- Searching for files outside the project directory

### Grep
- Searching file contents outside the project directory

### WebFetch
- Fetching URLs that could be exfiltration endpoints (sending data via query
  params to unknown hosts)

### WebSearch
- Searching for topics unrelated to the project or development

## DENY

These operations should be blocked outright — never allow them.

### Bash
- Catastrophic deletions: `rm -rf /`, `rm -rf ~`, or any command that would
  wipe the root filesystem or home directory
- Downloading and executing untrusted remote scripts (e.g. `curl ... | bash`,
  `wget ... | sh`, or piping remote content to an interpreter)
- Exfiltrating environment variables or secrets to external services (e.g.
  `curl` or `wget` with env vars, tokens, or key material in the URL or body)
- Disabling or bypassing security tools, hooks, or audit mechanisms (e.g.
  removing hook configurations, deleting security policy files, `--no-verify`
  on hooks designed for security)

## DEFAULT BEHAVIOR

When uncertain, use "ask" to defer to the human. It is better to let the
user decide than to auto-approve a potentially dangerous operation.
