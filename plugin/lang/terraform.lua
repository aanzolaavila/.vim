local mason_required = vim.list_extend(vim.g.mason_ensure_installed or {}, {
	"terraform-ls"
})
vim.g.mason_ensure_installed = mason_required

local treesitter_required = vim.list_extend(vim.g.treesitter_ensure_installed or {}, {
	"terraform",
	"hcl",
})
vim.g.treesitter_ensure_installed = treesitter_required

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "hcl", "terraform" },
	desc = "terraform/hcl commentstring configuration",
	command = "setlocal commentstring=#\\ %s",
})

local executed = false
vim.api.nvim_create_autocmd("FileType", {
	pattern = "terraform",
	callback = function(_)
		if executed then
			return
		end

		local telescope = require 'telescope'
		telescope.load_extension("terraform_doc")

		vim.keymap.set("n", "<localleader>sd", function()
			local docs = assert(telescope.extensions.terraform_doc)
			local terraform_doc = docs.terraform_doc
			terraform_doc({ full_name = 'hashicorp/aws' })
		end, { desc = "[S]earch [D]ocumentation from terraform" })

		executed = true
	end
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
		if client.name ~= 'terraformls' then
			return
		end

		-- disable semanticTokens due to a bug that freezes neovim
		client.server_capabilities.semanticTokensProvider = nil
	end
})

vim.lsp.enable("terraformls")
