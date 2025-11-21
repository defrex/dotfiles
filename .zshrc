
for rc in ~/.zshrc.d/* ; do
  source "$rc"
done

# bun completions
[ -s "/Users/defrex/.bun/_bun" ] && source "/Users/defrex/.bun/_bun"

# Created by `pipx` on 2025-09-03 14:55:16
export PATH="$PATH:/Users/defrex/.local/bin"

# Added by Antigravity
export PATH="/Users/defrex/.antigravity/antigravity/bin:$PATH"
