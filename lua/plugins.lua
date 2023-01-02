-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
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
  }

  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip'
    },
    config = function()
      require 'config.nvim-cmp'.setup()
    end
  }

  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    config = function()
      require 'config.nvim-treesitter'.setup()
    end,
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  -- File explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    config = function()
      require 'config.nvim-tree'.setup()
    end
  }

  -- Git related plugins
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require 'config.gitsigns'.setup()
    end
  }

  use {
    'navarasu/onedark.nvim', -- Theme inspired by Atom
    config = function()
      vim.cmd 'colorscheme onedark'
    end
  }

  use {
    'nvim-lualine/lualine.nvim', -- Fancier statusline
    config = function()
      require 'config.lualine'.setup()
    end,
  }

  use {
    'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
    config = function()
      require 'config.indent_blankline'.setup()
    end,
  }

  use {
    'numToStr/Comment.nvim', -- "gc" to comment visual regions/lines
    config = function()
      require 'config.comment'.setup()
    end,
  }

  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
  use 'norcalli/nvim-colorizer.lua' -- Blazing fast colors

  use { -- Autopairs
    "windwp/nvim-autopairs",
    config = function()
      require 'config.nvim-autopairs'.setup()
    end
  }

  use 'mbbill/undotree'
  use 'thaerkh/vim-indentguides'
  use 'wakatime/vim-wakatime'
  use 'folke/todo-comments.nvim'

  use {
    'natecraddock/sessions.nvim',
    config = function()
      require 'config.sessions'.setup()
    end
  }

  use {
    'natecraddock/workspaces.nvim',
    config = function()
      require 'config.workspaces'.setup()
    end
  }

  use {
    'lervag/wiki.vim',
    config = function()
      require 'config.wiki'.setup()
    end
  }

  use({
    "gbprod/yanky.nvim",
    config = function()
      require("config.yanky").setup()
    end
  })

  -- Fuzzy Finder (files, lsp, etc)
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'config.telescope'.setup()
    end
  }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    cond = vim.fn.executable 'make' == 1
  }

  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end
