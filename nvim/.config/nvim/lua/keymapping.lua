local map = vim.api.nvim_set_keymap

vim.g.mapleader = ','
--vim.g.maplocalleader=" "

map('n', '<leader>s', ':w<cr>', {noremap = true, silent = true})

map('i', 'kk', '<Esc>', {noremap = true})
map('', '<up>', '<nop>', {noremap = true})
map('', '<down>', '<nop>', {noremap = true})
map('', '<left>', '<nop>', {noremap = true})
map('', '<right>', '<nop>', {noremap = true})
map('n', '<leader>c', ':nohl<CR>', {noremap = true, silent = true})

map('n', '<Leader>ff', ":lua require'telescope.builtin'.find_files{}<CR>", { noremap = true, silent = true })
map('n', '<Leader>pp', ":lua require'telescope.builtin'.builtin{}<CR>", { noremap = true, silent = true })
map('n', '<Leader>g', ":lua require'telescope.builtin'.live_grep{}<CR>", { noremap = true, silent = true })
map('n', '<Leader><Space>', ":lua require'telescope.builtin'.buffers{}<CR>", { noremap = true, silent = true })
map('n', '<Leader>h', ":lua require'telescope.builtin'.help_tags{}<CR>", { noremap = true, silent = true })
map('n', '<Leader>t', ":lua require'telescope.builtin'.tags{}<CR>", { noremap = true, silent = true })

map('v', 'K', ":m '<-2<CR>gv=gv", {noremap = true})
map('v', 'J', ":m '>+1<CR>gv=gv", {noremap = true})

map('n', '<C-h>', '<C-w>h', {noremap = true, silent = true})
map('n', '<C-j>', '<C-w>j', {noremap = true, silent = true})
map('n', '<C-k>', '<C-w>k', {noremap = true, silent = true})
map('n', '<C-l>', '<C-w>l', {noremap = true, silent = true})

map('n', 'gh', ":lua require'lspsaga.provider'.lsp_finder()<CR>", { silent = true, noremap = true })

map('n', '<Leader>ca', ":lua require'lspsaga.codeaction'.code_action()", { silent = true, noremap = true })
map('v', '<Leader>ca', ":<C-U>lua require'lspsaga.codeaction'.range_code_action()<CR>", { silent = true, noremap = true })

map('n', 'K', ":lua require'lspsaga.hover'.render_hover_doc()<CR>", { silent = true, noremap = true })
map('n', 'gs', ":lua require'lspsaga.signaturehelp'.signature_help()<CR>", { silent = true, noremap = true })

map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

map('n', 'Y', 'y$', { noremap = true })
