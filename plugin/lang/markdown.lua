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
