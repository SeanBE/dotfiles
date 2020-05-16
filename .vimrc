set nocompatible	" makes vim more vi-compatible (off)
set noerrorbells	" ring bell for messages (off)

filetype plugin indent on	" turns on detection plugin and indent
syntax on 		" basic syntax highlighting

set hidden
set confirm
set modeline
set expandtab
set nowrap

set number relativenumber
set incsearch
set splitright

set tabstop=2
set shiftwidth=2
set softtabstop=2

set noswapfile
set nobackup

set smartindent
set smartcase
set scrolloff=3

set laststatus=2	" lightline
set encoding=utf-8
set history=1000  	" Keep more history, default is 20

set visualbell
set t_vb=

set signcolumn=yes
set clipboard=unnamedplus
set wildignore+=.git/**,node_modules/*

let mapleader = ","
"let mapleader="\<Space>"

" https://vim.fandom.com/wiki/Moving_lines_up_or_down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==

" Undo
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

call plug#begin('~/.vim/plugged')

" Visuals
Plug 'junegunn/goyo.vim'
Plug 'majutsushi/tagbar'
Plug 'itchyny/lightline.vim'
Plug 'daviesjamie/vim-base16-lightline'
Plug 'airblade/vim-gitgutter'
Plug '~/.local/share/base16-manager/chriskempson/base16-vim'

" Search
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Language
" TODO: read https://github.com/neoclide/coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ekalinin/Dockerfile.vim'
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" Misc
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vim-scripts/L9'	" extra vim utility funcs
call plug#end()

" Making my vim pretty
let base16colorspace=256
source ~/.vim/colorscheme.vim
let g:lightline = {
     \ 'colorscheme': 'base16',
\}

" FZF
let g:fzf_preview_window = ''

nmap ; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>s :Snippets<CR>
nmap <Leader>f :Rg<CR>

" Ale

" https://github.com/w0rp/ale#5iv-how-can-i-change-or-disable-the-highlights-ale-uses
let g:ale_set_highlights = 0
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
highlight! def link ALEErrorSign DiffDelete

let g:ale_go_golangci_lint_options = ''

let g:ale_fixers = {
\     'sh': ['remove_trailing_lines', 'shfmt', 'trim_whitespace'],
\     'python': ['black'],
\     'rust': ['remove_trailing_lines', 'rustfmt', 'trim_whitespace'],
\     'javascript': ['eslint', 'prettier'],
\     'vim': ['remove_trailing_lines', 'trim_whitespace'],
\     'go': ['gofmt', 'goimports', 'remove_trailing_lines', 'trim_whitespace']
\}


let g:ale_linters = {
\			'sh': ['language_server', 'shell', 'shellcheck'],
\     'rust': ['cargo', 'rls'],
\     'python': ['pylint', 'flake8', 'mypy'],
\     'go': ['gofmt', 'golangci-lint', 'govet'],
\    'javascript': ['eslint', 'prettier']
\}

" https://github.com/rust-lang/rfcs/pull/2912
let g:ale_rust_rls_toolchain = ''
let g:ale_rust_rls_executable = 'rust-analyzer'

"" Netrw
let g:netrw_banner = 0
let g:netrw_winsize = 15
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4

" https://www.reddit.com/r/vim/comments/6jcyfj/toggle_lexplore_properly/djdmsal?utm_source=share&utm_medium=web2x
let g:NetrwIsOpen=0
function! ToggleNetrw()
	if g:NetrwIsOpen
		let i = bufnr("$")
    while (i >= 1)
			if (getbufvar(i, "&filetype") == "netrw")
				silent exe "bwipeout " . i
      endif
			let i-=1
    endwhile
    let g:NetrwIsOpen=0
  else
    let g:NetrwIsOpen=1
    silent Lexplore
  endif
endfunction

" Add your own mapping. For example:
noremap <silent> <C-N> :call ToggleNetrw()<CR>

" Snippets
let g:UltiSnipsSnippetsDir = '~/.vim/snips/'
let g:UltiSnipsSnippetDirectories=[$HOME."/.vim/snips", "UltiSnips"] " TODO: make sure $HOME works..
