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

-- snippets

local ls = require 'luasnip'
local s, i, t, c = ls.s, ls.insert_node, ls.text_node, ls.choice_node
local rep = require("luasnip.extras").rep
local fmt = require 'luasnip.extras.fmt'.fmt

ls.add_snippets("terraform", {
	s("variable", fmt([[
	variable "{}" {{
		type        = {}
		description = "{}"
	}}]], { i(1, "variable"), i(2, "string"), i(3, "description") })),

	s("policy", fmt([[
	data "aws_iam_policy_document" "{}" {{
		version = "2012-10-17"

		statement {{
			effect = "Allow"
			actions = [

			]
			resources = [

			]
		}}
	}}
	]], { i(1) })),

	s("assume-policy", fmt([[
	data "aws_iam_policy_document" "{}" {{
		version = "2012-10-17"

		statement {{
			effect = "Allow"
			actions = [
				"sts:AssumeRole",
			]
			principals {{
				type        = "{}"
				identifiers = ["{}"]
			}}
		}}
	}}
	]], { i(1), i(2, "AWS"), i(3) })), -- TODO 'type' should be choice of AWS or Service

	s("vpc", fmt([[
	data "aws_vpc" "this" {{
		filter {{
			name   = "tag:Environment"
			values = ["{}"]
		}}
	}}
	]], { c(1, {
		t("dev"),
		t("prod"),
		i(nil),
	}) })),

	s("subnets", fmt([[
	data "aws_subnets" "{}" {{
		filter {{
			name   = "vpc-id"
			values = [data.aws_vpc.this.id]
		}}

		tags = {{
			Tier = "{}"
		}}
	}}
	]], { c(1, { t("public"), t("private") }), rep(1) })),

	s("remote_state", fmt([[
	data "terraform_remote_state" "{}" {{
		backend = "s3"
		config = {{
			bucket       = "treble-ai-shared-terraform-state"
			key          = "{}/{}.tfstate"
			region       = "us-east-1"
			encrypt      = true
			use_lockfile = true
			profile      = "shared"
		}}
	}}
	]], { i(1), i(2, "dev"), rep(1) })),


	s("tf_state", fmt([[
	terraform {{
		backend "s3" {{
			bucket       = "treble-ai-shared-terraform-state"
			key          = "{}/.tfstate"
			region       = "us-east-1"
			encrypt      = true
			use_lockfile = true
			profile      = "shared"
		}}

		required_providers {{
			aws = {{
				source  = "hashicorp/aws"
				version = "~> {}"
			}}
		}}
	}}

	provider "aws" {{
		region  = "us-east-1"
		profile = "{}"

		default_tags {{
			tags = {{
				ManagedBy   = "terraform"
				Environment = "{}"
				Service     = ""
				Repo        = "treble-ai/"
				Owner       = "platform"
			}}
		}}
	}}
	]], { i(1, "dev"), i(2, "6.32"), rep(1), rep(1) })),
})
