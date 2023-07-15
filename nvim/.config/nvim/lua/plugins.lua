-- packer repo (part of packpath)
-- ~/.local/share/nvim/site/pack/packer/start/packer.nvim
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

-- TODO: set versions
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-commentary'

  use { 'vimwiki/vimwiki', branch = 'dev' }

  --use 'ludovicchabant/vim-gutentags'

  use 'nvim-lua/popup.nvim'
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  use 'wincent/base16-nvim'

  use 'neovim/nvim-lspconfig'

  use "hrsh7th/nvim-cmp"

  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'

  use 'glepnir/lspsaga.nvim'

  use 'hoob3rt/lualine.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
end)

require("lsp")

vim.g.vimwiki_global_ext = 0
-- set vimwiki default path and syntax and disable all mappings
vim.g.vimwiki_list = {{path='~/.notes', syntax='markdown', ext='.md'}}
-- auto tags=1, auto_toc=1, auto_diary_index=1
--vim.g.vimwiki_key_mappings = { global=0, mouse=0 }
vim.g.vimwiki_key_mappings = { all_map = 0 }
vim.g.vimwiki_auto_chdir = 1
vim.g.vimwiki_diary_frequency = 'weekly'
vim.g.vimwiki_diary_rel_path = 'journal/'
vim.g.vimwiki_diary_index = 'journals'
vim.g.vimwiki_diary_header = 'Journal'
vim.g.vimwiki_diary_caption_level = 0

 vim.api.nvim_command('au BufNewFile ~/.notes/journal/*.md call setline(1, "# ".expand(\'%:t\')[:9]." (Created at ".strftime(\'%Y-%m-%d-%H%M\').")")')

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}


require'lualine'.setup {
  options = {
    icons_enabled = false,
    component_separators = {},
    section_separators = {},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '-L',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}
