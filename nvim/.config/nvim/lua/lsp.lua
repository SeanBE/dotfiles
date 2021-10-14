local nvim_lsp = require 'lspconfig'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

local servers = { 'clangd', 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

local pyright_root_path = vim.fn.getenv 'HOME' .. '/.local/share/nvim/lspinstall/python/node_modules'
local pyright_binary = pyright_root_path .. '/.bin/pyright-langserver'
require'lspconfig'.pyright.setup{
    on_attach = on_attach,
    capabilities=capabilities,
    --cmd = { "/home/sean/.local/share/nvim/lspinstall/python/node_modules/.bin/pyright-langserver", "--stdio" },
  	cmd = { pyright_binary, '--stdio' },
}
--    handlers = {
--      ["textDocument/publishDiagnostics"] = vim.lsp.with(
--          vim.lsp.diagnostic.on_publish_diagnostics, {
--              virtual_text = { spacing = 0, prefix = "!" },
--              signs = true,
--              underline = false,
--              update_in_insert = true
--          })
--    },
--    settings = {
--        python = {
--            analysis = {
--                typeCheckingMode = true,
--                autoSearchPaths = true,
--                useLibraryCodeForTypes = true
--            }
--        }
--    }
--}

require'lspconfig'.efm.setup{
    filetypes = { "python" },
    cmd = { "/home/sean/.local/share/nvim/lspinstall/efm/efm-langserver" },
    init_options = {documentFormatting = true},
    settings = {
        languages = {
            python = {
                {formatCommand = "black --quiet -", formatStdin = true},
                {formatCommand = "isort --quiet -", formatStdin = true}
            }
        }
    }
}

--require"lspconfig"["pyright"].manager.try_add_wrapper()
--require"lspconfig"["efm"].manager.try_add_wrapper()
--vim.api.nvim_command([[au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]])

local saga = require 'lspsaga'
saga.init_lsp_saga()

local luasnip = require 'luasnip'

local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
