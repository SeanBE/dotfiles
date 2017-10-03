set nocompatible              
filetype off                  
filetype plugin on
syntax on

set hidden
set confirm
set history=100
set laststatus=2
set encoding=utf-8 

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set splitright

map <F2> :NERDTreeToggle<CR>

call plug#begin('~/.vim/plugged') "syntax enabled + filetype plugin indent on
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
call plug#end()

let NERDTreeIgnore = ['\.pyc$', '__pycache__']

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

