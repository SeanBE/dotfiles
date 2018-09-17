" Markdown specific settings.
setlocal textwidth=80
setlocal colorcolumn=+1

" add all in directory. gitignore only accepts itself + .md
autocmd BufWritePost * execute '! git -C $HOME/.notes/ add --all; git -C $HOME/.notes/ diff-index --quiet HEAD || git -C $HOME/.notes/ commit -q --no-status -m %;'

