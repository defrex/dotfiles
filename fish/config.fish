
# start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx
    end
end


. ~/.config/fish/utils.fish
. ~/.config/fish/virtual.fish
. ~/.config/fish/prompt.fish
. ~/.config/fish/jump.fish
. ~/.config/fish/node_bin.fish


function set_django_settings --on-event virtualenv_did_activate
  set -gx DJANGO_SETTINGS_MODULE (basename $VIRTUAL_ENV)".settings.local"
end


function mkdir; command mkdir --parents $argv; end
function packer; command packer --noedit $argv; end
function pcat; pygmentize $argv ^&-; or cat $argv; end
function gst; git status $argv; end
function gca; git commit -av $argv; end
function serve; python -m http.server; end
function subl; subl3 $argv; end
function su; command su --shell=/usr/bin/fish $argv; end

. (ssh-agent) >&- ^&-; ssh-add >&- ^&-

set fish_greeting '>-->'

set -x BROWSER /usr/bin/chromium
set -x CHROME_BIN $BROWSER
set -x TERMINAL terminator

set -x PATH $PATH "$HOME/bin" "$HOME/.gem/ruby/1.9.1/bin" "$HOME/.gem/ruby/2.0.0/bin"
