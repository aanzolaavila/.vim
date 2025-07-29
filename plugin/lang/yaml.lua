local treesitter_required = vim.list_extend(vim.g.treesitter_ensure_installed or {}, {
	"yaml",
})
vim.g.treesitter_ensure_installed = treesitter_required

local store = require 'schemastore'

vim.lsp.config('yamlls', {
	settings = {
		keyOrdering = false,
		format = {
			enable = true,
		},
		validate = true,
		schemaStore = {
			-- Must disable built-in schemaStore support to use
			-- schemas from SchemaStore.nvim plugin
			enable = false,
			-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
			url = "",
		},
		schemas = store.yaml.schemas(),
	}
})

vim.lsp.config('redhat', {
	settings = {
		telemetry = {
			enabled = false,
		},
	}
})

vim.lsp.enable({ 'yamlls', 'redhat' })
