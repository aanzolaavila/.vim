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
    build = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    config = function()
      require 'config.nvim-treesitter'.setup()
    end,
  },

  {
    'p00f/nvim-ts-rainbow',
    dependencies = {
      'nvim-treesitter/nvim-treesitter'
    }
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
      require 'onedark'.setup {
        style = 'warm'
      }
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

  {
    'folke/todo-comments.nvim',
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require 'config.todo-comments'.setup()
    end
  },

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

  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require 'config.trouble'.setup()
    end
  },

  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require 'config.refactoring'.setup()
    end
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("config.null-ls").setup()
    end
  },

  {
    "olexsmir/gopher.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    build = function()
      vim.cmd [[GoInstallDeps]]
    end,
    config = function()
      require("config.nvim-gopher").setup()
    end
  },

  {
    'simrat39/rust-tools.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim'
    },
    config = function()
      require 'config.nvim-telescope'.setup()
    end
  },
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
