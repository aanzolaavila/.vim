local treesitter_required = vim.list_extend(vim.g.treesitter_ensure_installed or {}, {
	"typescript",
	"tsx",
})
vim.g.treesitter_ensure_installed = treesitter_required

local shared_settings = {
	inlayHints = {
		includeInlayEnumMemberValueHints = true,
		includeInlayFunctionLikeReturnTypeHints = true,
		includeInlayFunctionParameterTypeHints = true,
		includeInlayParameterNameHints = "literal",
		includeInlayParameterNameHintsWhenArgumentMatchesName = false,
		includeInlayPropertyDeclarationTypeHints = true,
		includeInlayVariableTypeHints = false,
		includeInlayVariableTypeHintsWhenTypeMatchesName = false,
	},
	referencesCodeLens = {
		enabled = true,
		showOnAllFunctions = true,
	}
}

vim.lsp.config('ts_ls', {
	settings = {
		typescript = shared_settings,
		javascript = shared_settings,
		completions = {
			completeFunctionCalls = true,
		},
	}
})

vim.lsp.enable('ts_ls')
