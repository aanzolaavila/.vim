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
