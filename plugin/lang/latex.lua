-- config of vimtex
vim.g.vimtex_mappings_disable = { ["n"] = { "K" } }
vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"

vim.pack.add({
	{ src = 'https://github.com/lervag/vimtex' },
})

local mason_required = vim.list_extend(vim.g.mason_ensure_installed or {}, {
	"texlab",
})
vim.g.mason_ensure_installed = mason_required

local treesitter_required = vim.list_extend(vim.g.treesitter_ensure_installed or {}, {
	"bibtex",
})
vim.g.treesitter_ensure_installed = treesitter_required

vim.lsp.config('texlab', {
	settings = {
		texlab = {
			bibtexFormatter = "texlab",
			build = {
				args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
				executable = "latexmk",
				forwardSearchAfter = false,
				onSave = false
			},
			chktex = {
				onEdit = false,
				onOpenAndSave = false
			},
			diagnosticsDelay = 300,
			formatterLineLength = 80,
			forwardSearch = {
				args = {}
			},
			latexFormatter = "latexindent",
			latexindent = {
				modifyLineBreaks = false
			}
		}
	}
})

vim.lsp.enable 'texlab'
