# Prefer 'fresh' where it's installed (macOS), fall back to whatever this box has.
for _ed in fresh nvim vim vi; do
    if command -v "$_ed" >/dev/null 2>&1; then
        export EDITOR="$_ed"
        break
    fi
done
unset _ed
