local function supports_formatting(client)
	return client:supports_method('textDocument/formatting')
end

local function should_autoformat_by_default()
	return os.getenv("AT_WORK") ~= "true"
end
local function set_keymaps(bufnr)
	local function map(modes, keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set(modes, keys, func, { buffer = bufnr, desc = desc })
	end

	local picker = require('mini.extra').pickers.lsp

	-- Following same keymaps as defined on `:h news-0.11`
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
end

local function set_commands(bufnr, client)
	local function cmd(command, func, opts)
		if opts and opts.desc then
			opts.desc = 'LSP: ' .. opts.desc
		end

		vim.api.nvim_buf_create_user_command(bufnr, command, func, opts)
	end

	-- Lesser used LSP functionality
	cmd("LspWorkspaceAddFolder", vim.lsp.buf.add_workspace_folder, { desc = 'Add workspace folder' })
	cmd("LspWorkspaceRemoveFolder", vim.lsp.buf.remove_workspace_folder, { desc = 'Remove workspace folder' })
	cmd("LspWorkspaceListFolders", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, { desc = 'List workspace folders' })
	cmd("LspStopAll", function()
		-- REF: https://neovim.io/doc/user/lsp.html#lsp-faq
		local clients = vim.lsp.get_clients()
		for _, c in ipairs(clients) do
			c.stop(c, false)
		end
	end, { desc = 'Restart all LSP clients' })
	cmd("LspToggleInlayHint", function()
		local is_enabled = vim.lsp.inlay_hint.is_enabled()
		vim.lsp.inlay_hint.enable(not is_enabled)
	end, { desc = 'Toggle Inlay Hints' })

	-- Create a command `:Format` local to the LSP buffer
	cmd('LspFormat', function(_)
		if supports_formatting(client) then
			vim.lsp.buf.format()
			vim.notify("Buffer formatted")
		else
			vim.notify("LSP server does not support formatting", vim.log.levels.WARN)
		end
	end, { desc = 'Format current buffer with LSP' })

	cmd('LspToggleBufAutoformat', function(_)
		vim.b.autofmt_enabled = not vim.b.autofmt_enabled
	end, { desc = 'Format current buffer with LSP on save' })

	cmd('LspToggleGlobalAutoformat', function(_)
		vim.g.autofmt_enabled = not vim.g.autofmt_enabled
	end, { desc = 'Format current buffer with LSP on save globally' })

	-- LSP logs related commands
	vim.api.nvim_create_user_command("LspEnableLogs", function()
		vim.lsp.log.set_level(vim.log.levels.WARN)
	end, { desc = "Enables LSP logs" })

	vim.api.nvim_create_user_command("LspDisableLogs", function()
		vim.lsp.log.set_level(vim.log.levels.OFF)
	end, { desc = "Disables LSP logs" })
end

local function set_autocmds(bufnr, client)
	vim.api.nvim_create_autocmd("BufWritePre", {
		buffer = bufnr,
		callback = function()
			if not supports_formatting(client) or not should_autoformat_by_default() then
				return
			end

			if vim.g.autofmt_enabled and vim.b.autofmt_enabled then
				vim.lsp.buf.format {
					async = false,
				}
			end
		end,
	})
end

local function on_attach(event)
	local bufnr = event.buf
	local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

	-- Global/Buffer variables
	vim.b.autofmt_enabled = true
	vim.g.autofmt_enabled = true

	set_keymaps(bufnr)
	set_commands(bufnr, client)
	set_autocmds(bufnr, client)

	-- Enable inlay hints if supported by LSP client
	-- REFERENCE: https://github.com/MysticalDevil/inlay-hints.nvim/blob/master/lua/inlay-hints/utils.lua
	if client:supports_method("textDocument/inlayHint") or client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true)
	end

	-- if client:supports_method('textDocument/completion') then
	-- 	vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
	-- end

	-- Set log level of LSP to off
	vim.lsp.log.set_level(vim.log.levels.OFF)
end

local augroup = vim.api.nvim_create_augroup

local lsp_group = augroup("lspconfig", { clear = true })
local function au(event, opts)
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
