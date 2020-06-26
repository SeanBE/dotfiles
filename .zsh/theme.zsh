# TODO: Prefix prompt with ($(pyenv version-name)) when pyenv virtualenv drops prompt
# TODO: purepower with 10k

# Originally from https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/Soliah.zsh-theme
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%})"
PROMPT='%{$fg[blue]%}%n%{$reset_color%}'
PROMPT+='@'
PROMPT+='%{$fg[red]%}%M%{$reset_color%}: %{$fg[blue]%}%~%b%{$reset_color%} $(git_prompt_info)'
PROMPT+='
$ '
