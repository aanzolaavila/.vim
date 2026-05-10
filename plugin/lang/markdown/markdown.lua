local mason_required = vim.list_extend(vim.g.mason_ensure_installed or {}, {
	"marksman",
	"markdownlint",
})
vim.g.mason_ensure_installed = mason_required

local treesitter_required = vim.list_extend(vim.g.treesitter_ensure_installed or {}, {
	"markdown",
	"markdown_inline",
})
vim.g.treesitter_ensure_installed = treesitter_required

vim.schedule(function()
	vim.fn["mkdp#util#install"]()
end)

vim.cmd([[do FileType]])

vim.lsp.enable("marksman")

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'markdown',
	callback = function(event)
		-- Adds the ability of setting/unsetting a checkbox in markdown
		vim.keymap.set('n', '<C-Space>', function()
			require('checkbox-toggle').toggle()
		end, { buf = event.buf })
	end
})

-- snippets

local ls = require 'luasnip'
local s, i = ls.s, ls.insert_node
local fmt = require 'luasnip.extras.fmt'.fmt

ls.add_snippets("markdown", {
	s("review", fmt([[
	Depends on:
	- TODO

	## Context

	{}

	## Description

	{}

	## How to test

	{}
	]], { i(3), i(1), i(2) })),

	s("smallreview", fmt([[
	Depends on:
	- TODO

	## Description

	{}
	]], { i(1) }))
})
