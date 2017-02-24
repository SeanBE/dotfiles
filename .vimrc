set nocompatible              
filetype off                  

set hidden
set confirm
set history=100
set laststatus=2
set encoding=utf-8 

call plug#begin('~/.vim/plugged') "syntax enabled + filetype plugin indent on
Plug 'tpope/vim-fugitive'
Plug 'L9'
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'daviesjamie/vim-base16-lightline'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
call plug#end()

let g:lightline = {
     \ 'colorscheme': 'base16',
     \ }

" http://johnmorales.com/blog/2015/01/09/base16-shell-tmux-vim-color-switching-dead-simple
if filereadable(expand("~/.vimrc_background"))
	let base16colorspace=256 " Access colors present in 256 colorspace
	source ~/.vimrc_background
endif

