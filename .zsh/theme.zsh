# TODO: Prefix prompt with ($(pyenv version-name)) when pyenv virtualenv drops prompt
# TODO: https://github.com/sindresorhus/pure

# Originally from https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/Soliah.zsh-theme
PROMPT='%{$fg[blue]%}%n%{$reset_color%}@%{$fg[red]%}%M%{$reset_color%}: %{$fg[blue]%}%~%b%{$reset_color%} $(check_git_prompt_info)
$ '

ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%})"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$reset_color%}"

# Git sometimes goes into a detached head state. git_prompt_info doesn't
# return anything in this case. So wrap it in another function and check
# for an empty string.
function check_git_prompt_info() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        if [[ -z $(git_prompt_info) ]]; then
            echo "%{$fg[magenta]%}detached-head%{$reset_color%})"
        else
            echo "$(git_prompt_info)"
        fi
    fi
}
