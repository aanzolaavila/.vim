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
	select = {
		-- enable = true,
		lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
		-- keymaps = {
		-- 	-- You can use the capture groups defined in textobjects.scm
		-- 	['aa'] = '@parameter.outer',
		-- 	['ia'] = '@parameter.inner',
		-- 	['af'] = '@function.outer',
		-- 	['if'] = '@function.inner',
		-- 	['ac'] = '@class.outer',
		-- 	['ic'] = '@class.inner',
		-- },
	},
	move = {
		-- enable = true,
		set_jumps = true, -- whether to set jumps in the jumplist
		-- goto_next_start = {
		-- 	[']m'] = '@function.outer',
		-- 	[']]'] = '@class.outer',
		-- },
		-- goto_next_end = {
		-- 	[']M'] = '@function.outer',
		-- 	[']['] = '@class.outer',
		-- },
		-- goto_previous_start = {
		-- 	['[m'] = '@function.outer',
		-- 	['[['] = '@class.outer',
		-- },
		-- goto_previous_end = {
		-- 	['[M'] = '@function.outer',
		-- 	['[]'] = '@class.outer',
		-- },
	},
	--[[ swap = {
		enable = true,
		swap_next = {
			['<leader>a'] = '@parameter.inner',
		},
		swap_previous = {
			['<leader>A'] = '@parameter.inner',
		},
	}, ]]
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

-- local opts = vim.tbl_deep_extend(
-- 	"force",
-- 	treesitter_opts,
-- 	textobjects_opts,
-- 	playground_opts
-- )

local opts = {
	install_dir = vim.fn.stdpath('data') .. '/site'
}

local treesitter = require('nvim-treesitter')
treesitter.setup(opts)
treesitter.install(ensure_installed)

-- Taken from: https://github.com/MeanderingProgrammer/treesitter-modules.nvim#implementing-yourself
-- For incremental selection see `:h treesitter-defaults`
-- v_an  - increment selection in visual mode
-- v_in  - decrement selection in visual mode
vim.api.nvim_create_autocmd('FileType', {
	group = vim.api.nvim_create_augroup('treesitter.setup', {}),
	callback = function(args)
		local buf = args.buf
		local filetype = args.match

		-- you need some mechanism to avoid running on buffers that do not
		-- correspond to a language (like oil.nvim buffers), this implementation
		-- checks if a parser exists for the current language
		local language = vim.treesitter.language.get_lang(filetype) or filetype
		if not vim.treesitter.language.add(language) then
			return
		end

		-- replicate `fold = { enable = true }`
		-- vim.wo.foldmethod = 'expr'
		-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

		-- replicate `highlight = { enable = true }`
		vim.treesitter.start(buf, language)

		-- replicate `indent = { enable = true }`
		vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

		-- `incremental_selection = { enable = true }` covered by 0.12.0
	end,
})

-- treesitter-textobjects
-- Disable entire built-in ftplugin mappings to avoid conflicts.
-- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
vim.g.no_plugin_maps = true
require('nvim-treesitter-textobjects').setup(textobjects_opts)

-- KEYMAPS

-- SELECT -----------------
-- You can use the capture groups defined in `textobjects.scm`
vim.keymap.set({ "x", "o" }, "am", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "im", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
end)
-- You can also use captures from other query groups like `locals.scm`
vim.keymap.set({ "x", "o" }, "as", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
end)

-- SWAP -------------------
vim.keymap.set("n", "<leader>a", function()
	require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
end, { desc = "TS: Swap next parameter" })
vim.keymap.set("n", "<leader>A", function()
	require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.outer"
end, { desc = "TS: Swap previous parameter" })

-- MOVE -------------------
vim.keymap.set({ "n", "x", "o" }, "]m", function()
	require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "]]", function()
	require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
end)
-- You can also pass a list to group multiple queries.
vim.keymap.set({ "n", "x", "o" }, "]o", function()
	require("nvim-treesitter-textobjects.move").goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
end)
-- You can also use captures from other query groups like `locals.scm` or `folds.scm`
vim.keymap.set({ "n", "x", "o" }, "]s", function()
	require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
end)
vim.keymap.set({ "n", "x", "o" }, "]z", function()
	require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds")
end)

vim.keymap.set({ "n", "x", "o" }, "]M", function()
	require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "][", function()
	require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "[m", function()
	require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[[", function()
	require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "[M", function()
	require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[]", function()
	require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
end)

-- Go to either the start or the end, whichever is closer.
-- Use if you want more granular movements
--[[ vim.keymap.set({ "n", "x", "o" }, "]d", function()
	require("nvim-treesitter-textobjects.move").goto_next("@conditional.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[d", function()
	require("nvim-treesitter-textobjects.move").goto_previous("@conditional.outer", "textobjects")
end) ]]

-- Prevent LSP from overwriting treesitter color settings
-- https://github.com/NvChad/NvChad/issues/1907
vim.hl.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level

local function test(a, b)
	return a + b
end
