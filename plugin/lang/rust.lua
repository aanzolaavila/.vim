local mason_required = vim.list_extend(vim.g.mason_ensure_installed or {}, {
	"rust-analyzer",
	"codelldb",
})
vim.g.mason_ensure_installed = mason_required

local treesitter_required = vim.list_extend(vim.g.treesitter_ensure_installed or {}, {
	"ron",
	"rust",
	"toml",
})
vim.g.treesitter_ensure_installed = treesitter_required

vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
				loadOutDirsFromCheck = true,
				runBuildScripts = true,
			},
			-- Add clippy lints for Rust.
			checkOnSave = {
				allFeatures = true,
				command = "clippy",
				extraArgs = { "--no-deps" },
			},
			procMacro = {
				enable = true,
				ignored = {
					["async-trait"] = { "async_trait" },
					["napi-derive"] = { "napi" },
					["async-recursion"] = { "async_recursion" },
				},
			},
			diagnostics = {
				enable = true,
				enableExperimental = true,
				disabled = { "unresolved-proc-macro" },
			},
		},
	}
})

vim.api.nvim_create_autocmd('BufRead', {
	pattern = "Cargo.toml",
	callback = function(_)
		-- completion = {
		--   cmp = { enabled = true },
		-- },
		require 'crates'.setup({})
	end
})

vim.lsp.enable({ "rust_analyzer", "codelldb" })
