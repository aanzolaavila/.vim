-- Install packer
local is_bootstrap = false

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  is_bootstrap = true
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
    config = function()
      require 'config.nvim-lspconfig'.setup()
    end,
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip'
    },
    config = function()
      require 'config.nvim-cmp'.setup()
    end
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    lazy = true,
    build = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    config = function()
      require 'config.nvim-treesitter'.setup()
    end,
  },

  {
    -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = 'nvim-treesitter',
  },

  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    config = function()
      require 'config.nvim-tree'.setup()
    end
  },

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require 'config.gitsigns'.setup()
    end
  },

  -- Appearance related plugins
  {
    'navarasu/onedark.nvim', -- Theme inspired by Atom
    config = function()
      vim.cmd 'colorscheme onedark'
    end
  },

  {
    'nvim-lualine/lualine.nvim', -- Fancier statusline
    config = function()
      require 'config.lualine'.setup()
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
    config = function()
      require 'config.indent_blankline'.setup()
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    }
  },

  {
    'folke/twilight.nvim',
    config = function()
      require 'twilight'.setup()
    end
  },

  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    config = function()
      require 'config.comment'.setup()
    end,
  },

  'tpope/vim-sleuth',            -- Detect tabstop and shiftwidth automatically
  'norcalli/nvim-colorizer.lua', -- Blazing fast colors

  {
    -- Autopairs
    "windwp/nvim-autopairs",
    config = function()
      require 'config.nvim-autopairs'.setup()
    end
  },

  'mbbill/undotree',
  'thaerkh/vim-indentguides',
  'wakatime/vim-wakatime',
  'folke/todo-comments.nvim',

  {
    'ggandor/leap.nvim',
    config = function()
      require 'config.leap'.setup()
    end
  },

  {
    'natecraddock/sessions.nvim',
    config = function()
      require 'config.nvim-sessions'.setup()
    end
  },

  {
    'natecraddock/workspaces.nvim',
    config = function()
      require 'config.workspaces'.setup()
    end
  },

  {
    'vimwiki/vimwiki',
    config = function()
      require 'config.wiki'.setup()
    end
  },

  {
    "gbprod/yanky.nvim",
    config = function()
      require("config.yanky").setup()
    end
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'config.nvim-telescope'.setup()
    end
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    lazy = true,
    build = 'make',
    cond = vim.fn.executable 'make' == 1
  },

  -- -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  -- local has_plugins, plugins = pcall(require, 'custom.plugins')
  -- if has_plugins then
  --   plugins(use)
  -- end
  --
  -- if is_bootstrap then
  --   require('packer').sync()
  -- end
})

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Lazy completes,'
  print '       then restart nvim'
  print '=================================='
  return
end
