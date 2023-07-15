CACHE_PATH = vim.fn.stdpath('cache')

local cmd = vim.cmd     				-- execute Vim commands
local exec = vim.api.nvim_exec 	-- execute Vimscript
local fn = vim.fn       				-- call Vim functions
local g = vim.g         				-- global variables
local o = vim.o         				-- global options
local b = vim.bo        				-- buffer-scoped options
local w = vim.wo        				-- windows-scoped options

o.mouse = 'a'
o.backup = false
o.clipboard = 'unnamedplus'
b.swapfile = false
o.syntax = 'enable'

o.grepprg='rg --no-heading --vimgrep'

o.inccommand = 'nosplit'

w.number = true
w.relativenumber = true
o.showmatch = true
w.foldmethod = 'marker'
w.colorcolumn = '80'
o.splitright = true
o.splitbelow = true
o.ignorecase = true
o.smartcase = true

-- remove whitespace on save
cmd([[au BufWritePre * :%s/\s\+$//e]])


o.breakindent = true
o.hidden = true
o.history = 1000
o.lazyredraw = true
b.synmaxcol = 300

o.termguicolors = true
cmd([[colorscheme flavours]])

b.expandtab = true
b.smartindent = true
--b.shiftwidth = 2
--b.tabstop = 4

cmd([[au BufEnter * set fo-=c fo-=r fo-=o]])
cmd([[autocmd FileType text,markdown,xml,html,xhtml,javascript setlocal cc=0]])
cmd([[autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2]])
cmd([[autocmd FileType go setlocal shiftwidth=8 tabstop=8]])

g.indentLine_char = '|'       -- set indentLine character
cmd([[autocmd FileType markdown let g:indentLine_enabled=0]])

--vim.g.indent_blankline_char = '┊'
--vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
--vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
--vim.g.indent_blankline_char_highlight = 'LineNr'
--vim.g.indent_blankline_show_trailing_blankline_indent = false

o.wrap = false
o.sidescrolloff = 8
o.conceallevel = 0
o.scrolloff = 8

o.completeopt = 'menuone,noselect'
o.shortmess = 'c'

o.updatetime = 300
o.wildmenu = true
o.wildmode = 'full'
--wildignore+=.hg,.git,.svn                    " version control
--wildignore+=go/pkg                           " go static files
--wildignore+=node_modules                     " js node modules
--wildignore+=go/bin                           " go bin files
--wildignore+=*.aux,*.out,*.toc                " latex intermediate files
--wildignore+=*.pdf,*.jpg,*.gif,*.png,*.jpeg   " binary images
--wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
--wildignore+=*.spl                            " compiled spelling word lists
--wildignore+=*.sw?                            " vim swap files
--wildignore+=*.pyc                            " python byte code

o.ttyfast = true
o.encoding = 'utf-8'
o.fileencoding = 'utf-8'
o.cmdheight = 1
o.hlsearch = true
o.pumheight = 10
o.showmode = false
o.undodir = CACHE_PATH .. "/undo"
o.undofile = true
o.writebackup = false
o.cursorline = true
o.numberwidth = 4
o.signcolumn = "yes"

