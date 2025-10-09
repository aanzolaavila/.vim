local treesitter_required = vim.list_extend(vim.g.treesitter_ensure_installed or {}, {
	"bash",
})
vim.g.treesitter_ensure_installed = treesitter_required

vim.lsp.enable("bashls")

-- snippets

local ls = require 'luasnip'
local s, i = ls.s, ls.insert_node
local fmt = require 'luasnip.extras.fmt'.fmt

ls.add_snippets("sh", {
	s("script", fmt([[
	#!/usr/bin/env bash
	set -o errexit
	set -o nounset
	set -o pipefail

	firstargument="${{1:-somedefaultvalue}}"

	echo "$firstargument]], {})),
})
