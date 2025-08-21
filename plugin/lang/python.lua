local mason_required = vim.list_extend(vim.g.mason_ensure_installed or {}, {
	"pyright",
	"ruff",
})
vim.g.mason_ensure_installed = mason_required

local treesitter_required = vim.list_extend(vim.g.treesitter_ensure_installed or {}, {
	"ninja",
	"python",
	"rst",
	"toml",
})
vim.g.treesitter_ensure_installed = treesitter_required

local venv_opts = {
	name = {
		"venv",
		".venv",
		"env",
		".env",
	},
}

require 'venv-selector'.setup(venv_opts)

vim.lsp.config('ruff', {
	capabilities = {
		hoverProvider = false
	}
})

vim.lsp.enable({ "pyright", "ruff" })

-- snippets

local ls = require 'luasnip'
local s, i = ls.s, ls.insert_node
local fmt = require 'luasnip.extras.fmt'.fmt

ls.add_snippets("python", {
	s("ayed", fmt([[
	def read(stdin) -> str:
		return stdin.readline().strip()

	def solve({}) -> {}:
		pass

	def main(stdin):
		line = read(stdin)

	from sys import stdin
	main(stdin)
	]], { i(1), i(2, "int") })),

	s("solve", fmt([[
	def solve({}) -> {}:
		pass
	]], { i(1), i(2, "int") }))
})
