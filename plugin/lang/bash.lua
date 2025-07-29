local treesitter_required = vim.list_extend(vim.g.treesitter_ensure_installed or {}, {
	"bash",
})
vim.g.treesitter_ensure_installed = treesitter_required

vim.lsp.enable("bashls")
