local mason_required = vim.list_extend(vim.g.mason_ensure_installed or {}, {
	"helm-ls"
})
vim.g.mason_ensure_installed = mason_required

vim.api.nvim_create_autocmd('LspAttach', {
	pattern = { "*.yaml", "*.yml" },
	callback = function(event)
		local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
		if client.name ~= "yamlls" then
			return
		end

		local bufnr = event.buf
		if vim.api.nvim_get_option_value("filetype", { buf = bufnr }) == "helm" then
			vim.schedule(function()
				vim.lsp.stop_client(client.id)
			end)
		end
	end
})

vim.lsp.enable("helm_ls")
