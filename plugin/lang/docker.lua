local mason_required = vim.list_extend(vim.g.mason_ensure_installed or {}, {
	"hadolint"
})
vim.g.mason_ensure_installed = mason_required

local treesitter_required = vim.list_extend(vim.g.treesitter_ensure_installed or {}, {
	"dockerfile",
})
vim.g.treesitter_ensure_installed = treesitter_required

vim.lsp.enable({
	"dockerls",
	"docker_compose_language_service",
})
