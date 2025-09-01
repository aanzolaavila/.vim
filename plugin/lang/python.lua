local mason_required = vim.list_extend(vim.g.mason_ensure_installed or {}, {
	"pyright",
	"ruff",
})
vim.g.mason_ensure_installed = mason_required

local treesitter_required = vim.list_extend(vim.g.treesitter_ensure_installed or {}, {
	"ninja",
	"python",
	"rst",
	"toml",
})
vim.g.treesitter_ensure_installed = treesitter_required

local venv_opts = {
	name = {
		"venv",
		".venv",
		"env",
		".env",
	},
}

local venv_selector = require 'venv-selector'
venv_selector.setup(venv_opts)

vim.lsp.config('ruff', {
	capabilities = {
		hoverProvider = false
	}
})

vim.lsp.config("pyright", {
	handlers = {
		-- Override the default rename handler to remove the `annotationId` from edits.
		--
		-- Pyright is being non-compliant here by returning `annotationId` in the edits, but not
		-- populating the `changeAnnotations` field in the `WorkspaceEdit`. This causes Neovim to
		-- throw an error when applying the workspace edit.
		--
		-- See:
		-- - https://github.com/neovim/neovim/issues/34731
		-- - https://github.com/microsoft/pyright/issues/10671
		[vim.lsp.protocol.Methods.textDocument_rename] = function(err, result, ctx)
			if err then
				vim.notify('Pyright rename failed: ' .. err.message, vim.log.levels.ERROR)
				return
			end

			---@cast result lsp.WorkspaceEdit
			for _, change in ipairs(result.documentChanges or {}) do
				for _, edit in ipairs(change.edits or {}) do
					if edit.annotationId then
						edit.annotationId = nil
					end
				end
			end

			local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
			vim.lsp.util.apply_workspace_edit(result, client.offset_encoding)
		end,
	},
})

vim.lsp.enable({ "pyright", "ruff" })

-- snippets

local ls = require 'luasnip'
local s, i = ls.s, ls.insert_node
local fmt = require 'luasnip.extras.fmt'.fmt

ls.add_snippets("python", {
	s("ayed", fmt([[
	def read(stdin) -> str:
		return stdin.readline().strip()

	def solve({}) -> {}:
		pass

	def main(stdin):
		line = read(stdin)

	from sys import stdin
	main(stdin)
	]], { i(1), i(2, "int") })),

	s("solve", fmt([[
	def solve({}) -> {}:
		pass
	]], { i(1), i(2, "int") }))
})
