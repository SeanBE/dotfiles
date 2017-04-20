set nocompatible              
filetype off                  

set hidden
set confirm
set history=100
set laststatus=2
set encoding=utf-8 

map <F2> :NERDTreeToggle<CR>

au BufRead,BufNewFile *.md setlocal textwidth=80|setlocal colorcolumn=+1

call plug#begin('~/.vim/plugged') "syntax enabled + filetype plugin indent on
Plug 'tpope/vim-fugitive'
Plug 'L9'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'daviesjamie/vim-base16-lightline'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'airblade/vim-gitgutter'
"Plug 'davidhalter/jedi-vim'
call plug#end()

let g:ctrlp_open_new_file = 'r'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

let g:lightline = {
     \ 'colorscheme': 'base16',
     \ }

" http://johnmorales.com/blog/2015/01/09/base16-shell-tmux-vim-color-switching-dead-simple
if filereadable(expand("~/.vimrc_background"))
	let base16colorspace=256 " Access colors present in 256 colorspace
	source ~/.vimrc_background
endif

