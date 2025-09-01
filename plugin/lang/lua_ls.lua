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


local ls = require 'luasnip'
local s, i = ls.snippet, ls.insert_node
local fmt = require 'luasnip.extras.fmt'.fmt
local rep = require 'luasnip.extras'.rep

ls.add_snippets('lua', {
	s({ trig = 'require' }, fmt("local {} = require '{}'", { i(1), rep(1) })),
})

vim.lsp.enable('lua_ls')
