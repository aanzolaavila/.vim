local mason_required = vim.list_extend(vim.g.mason_ensure_installed or {}, {
	"ty",
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

local venv_selector = require 'venv-selector'
---@diagnostic disable-next-line: undefined-field
venv_selector.setup(venv_opts)

vim.lsp.config('ruff', {
	capabilities = {
		hoverProvider = false
	}
})

vim.lsp.config('ty', {
	settings = {
		ty = {
			-- disableLanguageServices = true,
			experimental = {
				rename = true,
			},
		}
	}
})

vim.lsp.enable({ "ty", "ruff" })

-- snippets

local ls = require 'luasnip'
local s, i = ls.s, ls.insert_node
local fmt = require 'luasnip.extras.fmt'.fmt

ls.add_snippets("python", {
	s("ayed", fmt([[
	from sys import stdin
	from typing import TextIO


	def read(f: TextIO) -> str:
		return f.readline().strip()


	def solve() -> None: # T(n) = O(?)
		"""
		== Especificación ==
		Entrada:
			--
		Salida:
			--
		"""
		pass


	def main(f: TextIO):
		line = read(f)


	main(stdin)
	]], {})),

	s("solve", fmt([[
	def solve({}) -> {}:
		pass
	]], { i(1), i(2, "int") }))
})
