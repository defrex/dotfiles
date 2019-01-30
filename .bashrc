
export EDITOR='vim'

for rc in ~/.bashrc.d/* ; do
    source "$rc"
done
