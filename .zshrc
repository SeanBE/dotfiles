#zmodload zsh/zprof
source $HOME/.zsh/theme.zsh
source $HOME/.zsh/plugins.zsh

source $HOME/.zsh/aliases.zsh
source $HOME/.zsh/bindings.zsh

BASE16_SHELL="$HOME/.local/share/base16-manager/chriskempson/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

export PATH=/usr/local/go/bin:$PATH
export PATH=$(go env GOPATH)/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="/opt/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

source $HOME/.zsh/functions.zsh

umask 0002  # setting umask here since its being set to 0077 somewhere...
setopt noflowcontrol; stty -ixon
#zprof
