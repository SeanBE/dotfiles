local map = vim.api.nvim_set_keymap

map('n', '<leader>s', ':w<cr>', {noremap = true, silent = true})

map('i', '<Tab>', 'v:lua.tab_complete()', {expr = true})
map('s', '<Tab>', 'v:lua.tab_complete()', {expr = true})
map('i', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
map('s', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})

map('i', 'kk', '<Esc>', {noremap = true})
map('', '<up>', '<nop>', {noremap = true})
map('', '<down>', '<nop>', {noremap = true})
map('', '<left>', '<nop>', {noremap = true})
map('', '<right>', '<nop>', {noremap = true})
map('n', '<leader>c', ':nohl<CR>', {noremap = true, silent = true})

map('n', '<Leader>pp', ":lua require'telescope.builtin'.builtin{}<CR>", { noremap = true, silent = true })
map('n', '<Leader>rg', ":lua require'telescope.builtin'.live_grep{}<CR>", { noremap = true, silent = true })
map('n', ';', ":lua require'telescope.builtin'.buffers{}<CR>", { noremap = true, silent = true })
map('n', '<Leader>bfs', ":lua require'telescope.builtin'.find_files{}<CR>", { noremap = true, silent = true })

map('v', 'J', ":m '>+1<CR>gv=gv", {noremap = true})
map('v', 'K', ":m '<-2<CR>gv=gv", {noremap = true})

map('n', '<C-h>', '<C-w>h', {noremap = true, silent = true})
map('n', '<C-j>', '<C-w>j', {noremap = true, silent = true})
map('n', '<C-k>', '<C-w>k', {noremap = true, silent = true})
map('n', '<C-l>', '<C-w>l', {noremap = true, silent = true})

map('n', 'gh', ":lua require'lspsaga.provider'.lsp_finder()<CR>", { silent = true, noremap = true })

map('n', '<Leader>ca', ":lua require'lspsaga.codeaction'.code_action()", { silent = true, noremap = true })
map('v', '<Leader>ca', ":<C-U>lua require'lspsaga.codeaction'.range_code_action()<CR>", { silent = true, noremap = true })

map('n', 'K', ":lua require'lspsaga.hover'.render_hover_doc()<CR>", { silent = true, noremap = true })
map('n', 'gs', ":lua require'lspsaga.signaturehelp'.signature_help()<CR>", { silent = true, noremap = true })
