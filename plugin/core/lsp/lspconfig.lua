local globalAutoFmtEnabled = true;

local on_attach = function(args)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	-- ...
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.

	local bufnr = args.buf
	local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

	local map = function(modes, keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set(modes, keys, func, { buffer = bufnr, desc = desc })
	end

	local cmd = function(cmd, func, opts)
		if opts and opts.desc then
			opts.desc = 'LSP: ' .. opts.desc
		end

		vim.api.nvim_buf_create_user_command(bufnr, cmd, func, opts)
	end

	map('n', 'grn', vim.lsp.buf.rename, '[r]e[n]ame')
	map({ 'n', 'v' }, 'gra', vim.lsp.buf.code_action, 'code [a]ction')

	local telescope = require('telescope.builtin')
	local themes = require('telescope.themes')
	local with_cfg = require('util.telescope').with_cfg

	map('n', 'gd', with_cfg(telescope.lsp_definitions, themes.get_ivy, { initial_mode = 'normal' }),
		'[g]oto [d]efinition')

	map('n', 'grt', vim.lsp.buf.type_definition, 'Type [D]efinition')

	map('n', 'grr',
		with_cfg(telescope.lsp_references, themes.get_ivy,
			{
				initial_mode = 'normal',
				path_display = { smart = true },
				trim_text = true,
			}),
		'[g]oto [r]eferences')

	local short_display = {
		shorten = {
			len = 1,
			exclude = { -2, -1 },
		}
	}

	map('n', 'gri', with_cfg(telescope.lsp_implementations, themes.get_ivy, {
			initial_mode = 'normal',
			path_display = short_display,
			trim_text = true,
			jump_type = 'none',
		}),
		'[g]oto [i]mplementation')
	map('n', 'grI', with_cfg(telescope.lsp_implementations, themes.get_ivy, {
			initial_mode = 'normal',
			path_display = short_display,
			trim_text = true,
			jump_type = 'vsplit',
		}),
		'[g]oto [I]mplementation, in vsplit if only one choice')

	map('n', '<leader>D', function() vim.lsp.buf.declaration({ initial_mode = 'normal' }) end, '[g]oto [D]eclaration')
	map('n', '<leader>ws', with_cfg(telescope.lsp_dynamic_workspace_symbols, themes.get_ivy, {
			initial_mode = 'normal',
			path_display = { smart = true },
			trim_text = true
		}),
		'[w]orkspace [s]ymbols')

	-- See `:help K` for why this keymap
	map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
	map('n', '<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')

	-- Lesser used LSP functionality
	-- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
	cmd("LspWorkspaceAddFolder", vim.lsp.buf.add_workspace_folder, { desc = 'Add workspace folder' })
	-- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
	cmd("LspWorkspaceRemoveFolder", vim.lsp.buf.remove_workspace_folder, { desc = 'Remove workspace folder' })
	-- nmap('<leader>wl', function()
	--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, '[W]orkspace [L]ist Folders')
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
	local shouldAutoformatByDefault = function()
		return os.getenv("AT_WORK") ~= "true"
	end

	local supportsFormatting = function()
		return client:supports_method('textDocument/formatting')
	end

	cmd('Format', function(_)
		if supportsFormatting() then
			vim.lsp.buf.format()
			vim.print("Buffer formatted")
		else
			print("LSP server does not support formatting")
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
