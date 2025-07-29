local treesitter_required = vim.list_extend(vim.g.treesitter_ensure_installed or {}, {
	"json",
	"json5",
	"jsonc",
})
vim.g.treesitter_ensure_installed = treesitter_required

local store = require 'schemastore'

vim.lsp.config('jsonls', {
	settings = {
		format = {
			enable = true,
		},
		validate = { enable = true },
		schemas = store.json.schemas(),
	}
})

vim.lsp.enable('jsonls')
