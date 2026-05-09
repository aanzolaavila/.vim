local globalAutoFmtEnabled = true;

local on_attach = function(args)
	local bufnr = args.buf
	local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

	local function map(modes, keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set(modes, keys, func, { buffer = bufnr, desc = desc })
	end

	local function cmd(command, func, opts)
		if opts and opts.desc then
			opts.desc = 'LSP: ' .. opts.desc
		end

		vim.api.nvim_buf_create_user_command(bufnr, command, func, opts)
	end

	local picker = require('mini.extra').pickers.lsp

	map('n', 'grn', vim.lsp.buf.rename, '[r]e[n]ame')
	map({ 'n', 'v' }, 'gra', vim.lsp.buf.code_action, 'code [a]ction')
	map('n', 'gd', vim.lsp.buf.definition, '[g]oto [d]efinition')
	map('n', 'grt', function() picker { scope = 'type_definition' } end, 'Type [D]efinition')
	map('n', 'grr', function() picker { scope = 'references' } end, '[g]oto [r]eferences')
	map('n', 'gri', function() picker { scope = 'implementation' } end, '[g]oto [i]mplementation')
	map('n', '<leader>D', function() picker { scope = 'declaration' } end, '[g]oto [D]eclaration')
	map('n', '<leader>ws', function() picker { scope = 'workspace_symbol' } end, '[w]orkspace [s]ymbols')

	-- See `:help K` for why this keymap
	map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
	map('n', '<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')

	-- Lesser used LSP functionality
	cmd("LspWorkspaceAddFolder", vim.lsp.buf.add_workspace_folder, { desc = 'Add workspace folder' })
	cmd("LspWorkspaceRemoveFolder", vim.lsp.buf.remove_workspace_folder, { desc = 'Remove workspace folder' })
	cmd("LspWorkspaceListFolders", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, { desc = 'List workspace folders' })
	cmd("LspStopAll", function()
		-- REF: https://neovim.io/doc/user/lsp.html#lsp-faq
		vim.lsp.stop_client(vim.lsp.get_clients())
	end, { desc = 'Restart all LSP clients' })
	cmd("LspToggleInlayHint", function()
		local is_enabled = vim.lsp.inlay_hint.is_enabled()
		vim.lsp.inlay_hint.enable(not is_enabled)
	end, { desc = 'Toggle Inlay Hints' })


	-- Create a command `:Format` local to the LSP buffer
	local function shouldAutoformatByDefault()
		return os.getenv("AT_WORK") ~= "true"
	end

	local function supportsFormatting()
		return client:supports_method('textDocument/formatting')
	end

	cmd('Format', function(_)
		if supportsFormatting() then
			vim.lsp.buf.format()
			vim.print("Buffer formatted")
		else
			vim.notify("LSP server does not support formatting", vim.log.levels.WARN)
		end
	end, { desc = 'Format current buffer with LSP' })

	local localAutoFmtEnabled = true;
	cmd('ToggleBufAutoFormat', function(_)
		localAutoFmtEnabled = not localAutoFmtEnabled
	end, { desc = 'Format current buffer with LSP on save' })

	cmd('ToggleGlobalAutoFormat', function(_)
		globalAutoFmtEnabled = not globalAutoFmtEnabled
	end, { desc = 'Format current buffer with LSP on save globally' })

	vim.api.nvim_create_autocmd("BufWritePre", {
		buffer = bufnr,
		callback = function()
			if not supportsFormatting() or not shouldAutoformatByDefault() then
				return
			end

			if globalAutoFmtEnabled and localAutoFmtEnabled then
				vim.lsp.buf.format {
					async = false,
				}
			end
		end,
	})

	-- Enable inlay hints if supported by LSP client
	-- REFERENCE: https://github.com/MysticalDevil/inlay-hints.nvim/blob/master/lua/inlay-hints/utils.lua
	if client:supports_method("textDocument/inlayHint") or client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true)
	end
end

local augroup = vim.api.nvim_create_augroup

local lsp_group = augroup("lspconfig", { clear = true })
local au = function(event, opts)
	opts = opts or {}
	local default_opts = {
		group = lsp_group,
	}
	opts = vim.tbl_extend("force", default_opts, opts)
	vim.api.nvim_create_autocmd(event, opts)
end

au("LspAttach", {
	callback = on_attach,
})

vim.api.nvim_create_user_command("LspCapabilities", function()
	local clients = vim.lsp.get_clients()

	for _, client in pairs(clients) do
		---@diagnostic disable-next-line: undefined-field
		if client.name == "null-ls" then
			return
		end

		---@diagnostic disable-next-line: undefined-field
		local capAsList = {}
		---@diagnostic disable-next-line: undefined-field
		for key, value in pairs(client.server_capabilities) do
			if value and key:find("Provider") then
				local capability = key:gsub("Provider$", "")
				table.insert(capAsList, "  - " .. capability)
			end
		end

		table.sort(capAsList) -- sorts alphabetically
		---@diagnostic disable-next-line: undefined-field
		local msg = "# " .. client.name .. "\n" .. table.concat(capAsList, "\n")
		vim.print(msg)
	end
end, {})

-- Set log level of LSP to off
vim.lsp.log.set_level(vim.log.levels.OFF)
vim.api.nvim_create_user_command("LspEnableLogs", function()
	vim.lsp.log.set_level(vim.log.levels.WARN)
end, {})

vim.api.nvim_create_user_command("LspDisableLogs", function()
	vim.lsp.log.set_level(vim.log.levels.OFF)
end, {})
