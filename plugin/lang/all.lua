vim.lsp.config('*', {
	root_markers = { '.git', '.hg', '.jj' },
	capabilities = {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
			}
		}
	}
})

local augroup = vim.api.nvim_create_augroup

local default_group = augroup("lsp_all", { clear = true })
local au = function(event, opts)
	opts = opts or {}
	local default_opts = {
		group = default_group,
	}
	opts = vim.tbl_extend("force", default_opts, opts)
	vim.api.nvim_create_autocmd(event, opts)
end

au('LspAttach', {
	callback = function(event)
		-- This highlights objects from lsp when Cursor is hovering
		local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
		if not client:supports_method("textDocument/documentHighlight") then
			return
		end

		local bufnr = event.buf
		au('CursorHold', {
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight
		})
		au({ 'CursorMoved', 'InsertEnter' }, {
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references
		})
		au({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
			buffer = bufnr,
			callback = vim.lsp.codelens.refresh
		})
	end
})
