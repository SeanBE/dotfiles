" settings {{{
set nocompatible          " do not make vim vi-compatible
filetype plugin indent on	" turns on detection plugin and indent
syntax on 		            " basic syntax highlighting

set hidden                " hide buffer instead of unloading
set confirm               " show confirm dialog instead of failing
set noerrorbells	        " no beeps for messages
set modeline              " check lines for set commands
set modelines=5           " check 5 lines for set commands

set noswapfile            " dont store buffer changes into a swap file
set nobackup              " don't store backup
set nowritebackup         " don't store temp backup before overwriting

set number                " show line numbers
set relativenumber        " show line number relative to line with cursor
set splitright            " split vertical windows right to the current windows
set splitbelow            " split horizontal windows below to the current windows

if has("mouse_sgr")
  set mouse=a
	set ttymouse=sgr
end

" wildmenu {{{
set wildmenu              " enhance command line completion
set wildmode=full         " list all matches + complete first match

set wildignore+=*.pyc                            " python byte code
set wildignore+=.hg,.git,.svn                    " version control
set wildignore+=go/pkg                           " go static files
set wildignore+=node_modules                     " js node modules
set wildignore+=go/bin                           " go bin files
set wildignore+=*.aux,*.out,*.toc                " latex intermediate files
set wildignore+=*.pdf,*.jpg,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " vim swap files
" }}}

" undo {{{
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile
" }}}

set conceallevel=0              " do not hide markdown
set encoding=utf-8              " default encoding utf-8
set history=1000  	            " keep more history, default is 20
set backspace=indent,eol,start  " makes backspace key more powerful.
set signcolumn=yes              " always show sign column to avoid text shfit
set clipboard=unnamedplus       " unnamed register to the + register

set incsearch                   " shows the match while typing
set hlsearch                    " highlight found searches
set ignorecase                  " search case insensitive...
set smartcase                   " ... but not when search pattern contains upper case characters
set smartindent                 " smart indentation on new line.

set tabstop=4                   " a hard TAB displays as 4 columns
set shiftwidth=4                " operation >> indents 4 columns; << unindents 4 columns
set softtabstop=4               " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set expandtab                   " insert spaces when hitting TABs
set shiftround                  " round indent to multiple of shiftwidth

" lightline requires the following
set noshowmode                  " don't show mode in last line
set laststatus=2                " last window always has a status line

set nocursorcolumn              " do not highlight screen column of cursor
set nocursorline                " do not highlight text line of cursor (slows down screen redraw)
set noshowcmd                   " dont show partial cmd in last line of screen

set scrolloff=5                 " min number of lines to show above/below cursor when scrolling
set wrap                        " lines longer than textwidth of window will wrap
set visualbell                  " use visual bell instead of bell
set t_vb=                       " leave visual bell terminal code empty

set synmaxcol=300               " max num of columns to synax highlight
set ttyfast                     " indicate fast terminal connection

" Make :grep use ripgrep
if executable('rg')
    set grepprg=rg\ --color=never\ --vimgrep
endif

" }}}

" Plugins {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

"" Visuals
Plug 'junegunn/goyo.vim'

Plug 'majutsushi/tagbar'
Plug 'itchyny/lightline.vim'
Plug 'daviesjamie/vim-base16-lightline'
Plug 'airblade/vim-gitgutter'
Plug '~/.local/share/base16-manager/chriskempson/base16-vim'

"" Search
Plug '~/.zinit/plugins/junegunn---fzf'
Plug 'junegunn/fzf.vim'

"" Language
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'ekalinin/Dockerfile.vim'
Plug '~/dev/personal/notez.vim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'

"" reminder to run GoInstallBinaries on install.
Plug 'fatih/vim-go', { 'for': 'go' }

Plug 'rust-lang/rust.vim', { 'for': 'rust' }

"" Misc
Plug 'w0rp/ale'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-scripts/L9'	" extra vim utility funcs
call plug#end()
" }}}

" mappings {{{
let mapleader = ","
let maplocalleader="\<Space>"

" remove search highlight
nnoremap <Leader>h :nohlsearch<CR>

" disable entering Ex mode
nnoremap q: <Nop>
nnoremap Q <Nop>

" faster way of escaping insert mode
inoremap jk <ESC>

" easier split switching
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" trim whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Some useful quickfix shortcuts
" map <C-n> :cn<CR>
" map <C-m> :cp<CR>
" Close quickfix easily
" nnoremap <leader>a :cclose<CR>

" https://github.com/vim/vim/issues/5157
" https://vi.stackexchange.com/questions/84/how-can-i-copy-text-to-the-system-clipboard-from-vim
xnoremap <silent> "y y :call system("wl-copy", @")<CR>
nnoremap <silent> "p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<CR>p
" }}}

" filetype {{{
augroup vimrc_help
  " https://vi.stackexchange.com/a/4464
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END

au BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx

au FileType gitcommit setlocal spell
au FileType gitconfig,sh,toml set noexpandtab
au FileType text setlocal textwidth=80 fo+=2t ts=2 sw=2 sts=2 expandtab
au FileType dockerfile set noexpandtab
" }}}

" notez.vim {{{
"let g:loaded_notez = 1
let g:notez_dir="~/.notes"
" }}}

" colorscheme {{{
let base16colorspace=256
source ~/.vim/colorscheme.vim
let g:lightline = {
     \ 'colorscheme': 'base16',
\}
" }}}

" nerdtree {{{
let NERDTreeIgnore=['\~$', '\.git$', '\.pyc$', '\.egg-info$', '__pycache__', '__pycache__']
let NERDTreeMinimalUI = 1
noremap <silent> <C-n> :NERDTreeToggle<CR>
" }}}

" goyo {{{
let g:goyo_width = "90%"
let g:goyo_height = "80%"
" }}}

" vim-go {{{
" https://github.com/fatih/vim-go/issues/2829
let g:go_fmt_autosave = 1
let g:go_gopls_enabled = 0
let g:go_def_mapping_enabled = 0
let g:go_highlight_diagnostic_errors = 0
let g:go_highlight_diagnostic_warnings = 0
let g:go_highlight_trailing_whitespace_error=0
" }}}

" fzf {{{
" disable preview window altogether unless explicit
let g:fzf_preview_window = ''

nmap ; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>s :Snippets<CR>
nmap <Leader>f :Rg<CR>

" https://github.com/junegunn/fzf.vim/pull/704#issuecomment-450655634
command! -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>),
  \   1,
  \   {'options': '--delimiter : --nth 2..'})
" }}}

" ale {{{
let g:ale_fixers = {
\   'sh': ['remove_trailing_lines', 'shfmt', 'trim_whitespace'],
\   'python': ['black', 'isort'],
\   'sql': ['pgformatter'],
\   'rust': ['remove_trailing_lines', 'rustfmt', 'trim_whitespace'],
\   'javascript': ['eslint', 'prettier'],
\   'vim': ['remove_trailing_lines', 'trim_whitespace'],
\   'go': ['gofmt', 'goimports', 'remove_trailing_lines', 'trim_whitespace']
\}

let g:ale_linters = {
\   'sh': ['language_server', 'shell', 'shellcheck'],
\   'rust': ['cargo', 'rls'],
\   'python': ['flake8', 'mypy'],
\   'go': ['golangci-lint', 'gobuild'],
\   'javascript': ['eslint', 'prettier']
\}

let g:ale_disable_lsp = 1
" https://github.com/w0rp/ale#5iv-how-can-i-change-or-disable-the-highlights-ale-uses
let g:ale_set_highlights = 0
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
highlight! def link ALEErrorSign DiffDelete

let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0

let g:ale_go_golangci_lint_options = ''

" https://github.com/rust-lang/rfcs/pull/2912
let g:ale_rust_rls_toolchain = ''
let g:ale_rust_rls_executable = 'rust-analyzer'

let g:ale_python_black_options = '-S' " skip string normalization
" }}}

" coc.nvim {{{
set cmdheight=1           " number of screen lines to give command line
set updatetime=300        " better user experience. default is 400ms
set shortmess+=c          " don't pass messages to ins-completion-menu.


" coc python errors are because of:
" https://github.com/neoclide/coc-python/blob/master/src/interpreter/locators/services/currentPathService.ts#L56
" goes through all the suggestions (python3.7/3.6 etc) where pyenv will complain
" using coc with python just make sure to set the current interpreter.
" this preference is saved to coc/memos.json
let $NVIM_COC_LOG_LEVEL='error'
let $NVIM_COC_LOG_FILE='/tmp/coc-vim.log'

let g:coc_global_extensions = [
    \ 'coc-go',
    \ 'coc-pyright',
    \ 'coc-tsserver',
    \ 'coc-rust-analyzer'
\]

autocmd FileType markdown let b:coc_suggest_disable = 1

" }}}

" netrw {{{
let g:netrw_banner = 0
let g:netrw_winsize = 15
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_dirhistmax=0

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
" }}}

" snippets {{{
let g:UltiSnipsSnippetsDir = '~/.vim/snips/'
let g:UltiSnipsSnippetDirectories=[$HOME."/.vim/snips", "UltiSnips"]
" }}}

" gitgutter {{{
let g:gitgutter_map_keys = 0
" }}}

" white space highlight {{{
"highlight RedundantWhitespace ctermbg=green guibg=green
"match RedundantWhitespace /\s\+$\| \+\ze\t/
" }}}

" vim:ts=2:sw=2:sts=2:fdm=marker:foldlevel=0:et
