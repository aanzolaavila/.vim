local gopher_opts = {
	commands = {
		dlv = "dlv",
		go = "go",
		gomodifytags = "gomodifytags",
		iferr = "iferr",
		impl = "impl",
	},
	gotag = {
		transform = 'snakecase',
	},
}

local gopher = require 'gopher'
gopher.setup(gopher_opts)

local mason_required = vim.list_extend(vim.g.mason_ensure_installed or {}, {
	"gofumpt",
	"goimports",
	"gomodifytags",
	"impl"
})
vim.g.mason_ensure_installed = mason_required

local treesitter_required = vim.list_extend(vim.g.treesitter_ensure_installed or {}, {
	"go",
	"gomod",
	"gosum",
	"gowork",
})
vim.g.treesitter_ensure_installed = treesitter_required

vim.lsp.config('gopls', {
	settings = {
		gofumpt = true,
		codelenses = {
			gc_details = true,
			generate = true,
			regenerate_cgo = true,
			run_govulncheck = true,
			test = true,
			tidy = true,
			upgrade_dependency = true,
			vendor = true,
		},
		hints = { -- NOTE: this is EXPERIMENTAL
			assignVariableTypes = true,
			compositeLiteralFields = true,
			compositeLiteralTypes = true,
			constantValues = true,
			functionTypeParameters = true,
			parameterNames = true,
			rangeVariableTypes = true,
		},
		analyses = {
			nilness = true,
			shadow = true,
			unreachable = true,
			unusedparams = true,
			unusedvariable = true,
			unusedwrite = true,
			useany = true,
		},
		vulncheck = "Imports", -- NOTE: this is EXPERIMENTAL
		semanticTokens = true, -- NOTE: this is EXPERIMENTAL
		usePlaceholders = true,
		completeUnimported = true,
		staticcheck = true,
		directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
	},
})

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(event)
		local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
		if client.name ~= "terraformls" then
			return
		end

		-- disable semanticTokens
		client.server_capabilities.semanticTokensProvider = nil
	end
})

vim.lsp.enable('gopls')
