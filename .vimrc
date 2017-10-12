set nocompatible              
filetype off                  

syntax on
filetype plugin on
filetype plugin indent on

set hidden
set confirm
set modeline
set expandtab
set splitright
set history=100
set laststatus=2
set encoding=utf-8 

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'L9'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'daviesjamie/vim-base16-lightline'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'airblade/vim-gitgutter'
Plug 'vimwiki/vimwiki'
Plug 'ekalinin/Dockerfile.vim'
Plug 'w0rp/ale'
"Plug 'https://github.com/python-mode/python-mode'
call plug#end()

map <F2> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$', '__pycache__']

let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
highlight! def link ALEErrorSign DiffDelete

let g:ctrlp_open_new_file = 'r'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

let g:lightline = {
     \ 'colorscheme': 'base16',
     \ }

nmap <Leader>b :CtrlPBuffer<CR>

" http://johnmorales.com/blog/2015/01/09/base16-shell-tmux-vim-color-switching-dead-simple
if filereadable(expand("~/.vimrc_background"))
	let base16colorspace=256 " Access colors present in 256 colorspace
	source ~/.vimrc_background
endif

