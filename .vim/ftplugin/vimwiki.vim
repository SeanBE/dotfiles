" Markdown specific settings.
setlocal textwidth=120
setlocal colorcolumn=+1

" add all in directory. gitignore only accepts itself + .md
" based off https://opensource.com/article/18/6/vimwiki-gitlab-notes
" https://vi.stackexchange.com/questions/3060/suppress-output-from-a-vim-autocomand
autocmd BufWritePost * silent! execute '! git -C $HOME/.notes/ add \*.md; git -C $HOME/.notes/ diff-index --quiet HEAD || git -C $HOME/.notes/ commit -q --no-status -m %;'

