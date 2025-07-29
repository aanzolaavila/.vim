local default_required = {
	-- REQUIRED for neovim
	'c',
	'vim',
	'vimdoc',
	'lua',
	-- end REQUIRED
	'bash',
	'gitignore',
	'gitcommit',
	'make',
	'markdown',
	'markdown_inline',
}

local ensure_installed = vim.list_extend(vim.g.treesitter_ensure_installed or {}, default_required)

local treesitter_opts = {
	-- [[ Configure Treesitter ]]
	-- See `:help nvim-treesitter`
	configs = {
		-- Add languages to be installed here that you want installed for treesitter
		ensure_installed = ensure_installed,

		highlight = {
			enable = true,
			disable = function(_, buf)
				local max_size_kb = 500 -- KB
				local max_filesize = max_size_kb * 1024
				---@diagnostic disable-next-line: undefined-field
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					vim.notify(
						string.format("Disabled Treesitter for the current buffer, as it is bigger than %dKB",
							max_size_kb),
						vim.log.levels.WARN, { title = "Warning" })
					return true
				end
			end,
			additional_vim_regex_highlighting = false,
		},

		indent = {
			enable = true,
			disable = { 'python' },
		},

		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = '<C-n>',
				node_incremental = '<C-n>',
				scope_incremental = '<C-m>',
				node_decremental = '<C-b>',
			},
		},
	},
}

local textobjects_opts = {
	configs = {
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					['aa'] = '@parameter.outer',
					['ia'] = '@parameter.inner',
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
			swap = {
				enable = true,
				swap_next = {
					['<leader>a'] = '@parameter.inner',
				},
				swap_previous = {
					['<leader>A'] = '@parameter.inner',
				},
			},
		}
	}
}

local playground_opts = {
	configs = {
		playground = {
			enable = true,
		},
		query_linter = {
			enable = true,
		}
	}
}

local opts = vim.tbl_deep_extend(
	"force",
	treesitter_opts,
	textobjects_opts,
	playground_opts
)

require "nvim-treesitter".setup(opts)
local cfg = require 'nvim-treesitter.configs'
cfg.setup(opts.configs)

local install = require("nvim-treesitter.install")
install.prefer_git = true

-- Prevent LSP from overwriting treesitter color settings
-- https://github.com/NvChad/NvChad/issues/1907
vim.highlight.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level
