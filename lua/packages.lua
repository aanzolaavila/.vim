vim.pack.add({
	-- core ---------
	{ src = 'https://github.com/nvim-lua/plenary.nvim' },

	-- telescope
	{
		src = 'https://github.com/nvim-telescope/telescope.nvim',
		version = vim.version.range('~0.1.8'),
	},
	{ src = 'https://github.com/tom-anders/telescope-vim-bookmarks.nvim' },
	{ src = 'https://github.com/nvim-telescope/telescope-symbols.nvim' },

	-- treesitter
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },
	{ src = 'https://github.com/nvim-treesitter/playground' },

	-- lsp
	{
		src = 'https://github.com/mason-org/mason.nvim',
		version = vim.version.range('~2.0.1'),
	},
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/folke/neodev.nvim' },
	{ src = 'https://github.com/onsails/lspkind.nvim' },

	-- cmp
	{ src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
	{ src = 'https://github.com/hrsh7th/cmp-buffer' },
	{ src = 'https://github.com/hrsh7th/cmp-path' },
	{ src = 'https://github.com/hrsh7th/cmp-cmdline' },
	{ src = 'https://github.com/hrsh7th/nvim-cmp' },

	-- dap
	{ src = 'https://github.com/mfussenegger/nvim-dap' },

	-- lang --------
	-- python
	{ src = 'https://github.com/mfussenegger/nvim-dap-python' },
	{ src = 'https://github.com/linux-cultist/venv-selector.nvim',      version = 'main' },
	-- go
	{ src = 'https://github.com/olexsmir/gopher.nvim' },

	-- extras -----------
	-- coding
	{ src = 'https://github.com/Wansmer/treesj' },
	{ src = 'https://github.com/echasnovski/mini.icons',                version = 'stable' },
	{ src = 'https://github.com/folke/flash.nvim' },
	{ src = 'https://github.com/folke/todo-comments.nvim' },
	{ src = 'https://github.com/lewis6991/gitsigns.nvim' },
	{ src = 'https://github.com/mbbill/undotree' },
	{ src = 'https://github.com/nvim-tree/nvim-tree.lua' },
	{ src = 'https://github.com/nvim-tree/nvim-web-devicons' },
	{ src = 'https://github.com/rachartier/tiny-inline-diagnostic.nvim' },
	{ src = 'https://github.com/stevearc/oil.nvim' },
	{ src = 'https://github.com/tpope/vim-sleuth' },
	{ src = 'https://github.com/windwp/nvim-autopairs' },
	{ src = 'https://github.com/L3MON4D3/LuaSnip',                      version = vim.version.range('~2.0') },
	{ src = 'https://github.com/saadparwaiz1/cmp_luasnip', },
	{ src = 'https://github.com/rafamadriz/friendly-snippets' },
	{ src = 'https://github.com/numToStr/Comment.nvim' },

	-- util
	{ src = 'https://github.com/Asheq/close-buffers.vim' },
	{ src = 'https://github.com/folke/persistence.nvim' },
	{ src = 'https://github.com/tpope/vim-fugitive' },
	{ src = 'https://github.com/gierens/vim-rfc',                       version = 'c8c61a2' },
	{ src = 'https://github.com/wakatime/vim-wakatime' },
	{ src = 'https://github.com/lukas-reineke/indent-blankline.nvim' },
	{ src = 'https://github.com/folke/which-key.nvim' },
	{ src = 'https://github.com/vimwiki/vimwiki' },

	-- lualine
	{ src = 'https://github.com/nvim-lualine/lualine.nvim' },
	{ src = 'https://github.com/linrongbin16/lsp-progress.nvim' },

	-- schema store for yaml schema support
	{ src = 'https://github.com/b0o/SchemaStore.nvim' },

	-- helm
	{ src = 'https://github.com/towolf/vim-helm' },

	-- terraform
	{ src = 'https://github.com/ANGkeith/telescope-terraform-doc.nvim' },

	-- markdown
	{ src = 'https://github.com/iamcco/markdown-preview.nvim' },

	-- rust
	{ src = 'https://github.com/Saecki/crates.nvim' },
})
