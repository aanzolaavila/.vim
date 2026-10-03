local mason_required = vim.list_extend(vim.g.mason_ensure_installed or {}, {
	"clangd",
})
vim.g.mason_ensure_installed = mason_required

local treesitter_required = vim.list_extend(vim.g.treesitter_ensure_installed or {}, {
	"c",
})
vim.g.treesitter_ensure_installed = treesitter_required

local opts = {
	-- Add custom command-line flags:
	cmd = { 'clangd', '--background-index', '--clang-tidy' },
}

vim.lsp.config('clangd', opts)
vim.lsp.enable('clangd')
