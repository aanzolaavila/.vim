vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			workspace = {
				checkThirdParty = false,
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false
			},
			diagnostics = {
				globals = { 'vim' },
			},
			completion = {
				callSnippet = 'Replace',
			}
		},
	},
})

vim.lsp.enable('lua_ls')
