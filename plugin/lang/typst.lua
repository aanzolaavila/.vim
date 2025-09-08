local mason_required = vim.list_extend(vim.g.mason_ensure_installed or {}, {
	"tinymist"
})
vim.g.mason_ensure_installed = mason_required


local treesitter_required = vim.list_extend(vim.g.treesitter_ensure_installed or {}, {
	"typst",
})
vim.g.treesitter_ensure_installed = treesitter_required

vim.lsp.config("typst", {
	cmd = { "tinymist" },
	filetypes = { "typst" },
	settings = {

	}
})

vim.lsp.enable("typst")

local typst_preview = require 'typst-preview'
typst_preview.setup()

vim.api.nvim_create_autocmd(
	{ "BufNewFile", "BufRead" },
	{
		pattern = "*.typ",
		callback = function()
			vim.cmd [[ setfiletype typst ]]
		end
	}
)
