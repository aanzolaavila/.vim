vim.pack.add({
	-- core ---------
	{ src = 'https://github.com/nvim-lua/plenary.nvim' },
	{ src = 'https://github.com/nvim-mini/mini.nvim' },

	-- treesitter
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },
	-- { src = 'https://github.com/nvim-treesitter/playground' },

	-- lsp
	{ src = 'https://github.com/mason-org/mason.nvim',                       version = vim.version.range('~2.2.1') },
	-- { src = 'https://github.com/mason-org/mason-lspconfig.nvim',             version = vim.version.range('~2.3.0') },
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

	-- extras -----------
	-- coding
	{ src = 'https://github.com/Wansmer/treesj' },
	{ src = 'https://github.com/folke/todo-comments.nvim' },
	{ src = 'https://github.com/lewis6991/gitsigns.nvim' },
	{ src = 'https://github.com/nvim-tree/nvim-web-devicons' },
	{ src = 'https://github.com/rachartier/tiny-inline-diagnostic.nvim' },
	{ src = 'https://github.com/tpope/vim-sleuth' },
	{ src = 'https://github.com/windwp/nvim-autopairs' },
	{ src = 'https://github.com/L3MON4D3/LuaSnip',                           version = vim.version.range('~2.0') },
	{ src = 'https://github.com/saadparwaiz1/cmp_luasnip', },
	{ src = 'https://github.com/rafamadriz/friendly-snippets' },
	{ src = 'https://github.com/numToStr/Comment.nvim' },

	-- util
	{ src = 'https://github.com/Asheq/close-buffers.vim' },
	{ src = 'https://github.com/tpope/vim-fugitive' },
	{ src = 'https://github.com/gierens/vim-rfc',                            version = 'c8c61a2' },
	{ src = 'https://github.com/wakatime/vim-wakatime' },
	{ src = 'https://github.com/lukas-reineke/indent-blankline.nvim' },
	{ src = 'https://github.com/vimwiki/vimwiki' },
	{ src = 'https://github.com/zk-org/zk-nvim' },
	{ src = 'https://github.com/mattn/calendar-vim' },
	{ src = 'https://github.com/freitass/todo.txt-vim' },
	{ src = "https://github.com/obsidian-nvim/obsidian.nvim",                version = vim.version.range "*", },
	{ src = 'https://github.com/3rd/image.nvim' }, -- for image rendering

	-- lualine
	{ src = 'https://github.com/nvim-lualine/lualine.nvim' },
	{ src = 'https://github.com/linrongbin16/lsp-progress.nvim' },

	-- lang --------
	-- schema store for yaml schema support
	{ src = 'https://github.com/b0o/SchemaStore.nvim' },

	-- python
	{ src = 'https://github.com/mfussenegger/nvim-dap-python' },
	{ src = 'https://github.com/linux-cultist/venv-selector.nvim',           version = 'main' },

	-- go
	{ src = 'https://github.com/olexsmir/gopher.nvim' },

	-- helm
	{ src = 'https://github.com/towolf/vim-helm' },

	-- markdown
	{ src = 'https://github.com/iamcco/markdown-preview.nvim' },

	-- rust
	{ src = 'https://github.com/Saecki/crates.nvim' },

	-- typst
	{ src = 'https://github.com/chomosuke/typst-preview.nvim',               version = vim.version.range("~1") },

	-- arduino
	{ src = 'https://github.com/stevearc/vim-arduino' },

	-- quarto
	{ src = 'https://github.com/quarto-dev/quarto-nvim' },
	{ src = 'https://github.com/jmbuhr/otter.nvim' },
})

-- native undotree
vim.schedule(function() vim.cmd [[ packadd nvim.undotree ]] end)

-- My WIP plugins
-- terraform
vim.opt.rtp:prepend(vim.fn.expand '~/code/development/terraform-doc.nvim')

-- Cleanup unused plugins
local function pack_clean()
	local active_plugins = {}
	local unused_plugins = {}

	for _, plugin in ipairs(vim.pack.get()) do
		active_plugins[plugin.spec.name] = plugin.active
	end

	for _, plugin in ipairs(vim.pack.get()) do
		if not active_plugins[plugin.spec.name] then
			table.insert(unused_plugins, plugin.spec.name)
		end
	end

	if #unused_plugins == 0 then
		return
	end

	local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
	if choice == 1 then
		vim.pack.del(unused_plugins)
	end
end

vim.api.nvim_create_autocmd('VimEnter', {
	callback = pack_clean
})
