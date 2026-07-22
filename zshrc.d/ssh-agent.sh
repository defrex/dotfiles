# Reuse a running ssh-agent across shells; only spawn one if none is reachable.
# Without this guard, every shell startup forks a new daemonized ssh-agent that
# re-parents to launchd and never dies — heavy shell-spawning automation can
# exhaust `ulimit -u` and break fork() machine-wide.
SSH_ENV="$HOME/.ssh/agent-env"

[ -f "$SSH_ENV" ] && . "$SSH_ENV" > /dev/null 2>&1

# `ssh-add -l` exit codes: 0 = agent has keys, 1 = agent reachable but empty,
# 2 = no agent reachable. Only start a fresh agent in the last case.
ssh-add -l > /dev/null 2>&1
if [ $? -eq 2 ]; then
  ssh-agent -s > "$SSH_ENV"
  chmod 600 "$SSH_ENV"
  . "$SSH_ENV" > /dev/null
  ssh-add > /dev/null 2>&1
fi
