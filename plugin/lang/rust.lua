local mason_required = vim.list_extend(vim.g.mason_ensure_installed or {}, {
	-- "rust-analyzer", -- it is better to use the one from asdf, otherwise many things wont work
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
				buildScripts = {
					enable = true,
				}
			},
			check = { command = "clippy" },
			inlayHints = {
				bindingModeHints = { enabled = true },
				closureCaptureHints = { enabled = true },
				closureReturnTypeHints = { enable = "always" },
				maxLength = 100,
			},
			rustc = { source = "discover" },
			-- Add clippy lints for Rust.
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
				-- disabled = { "unresolved-proc-macro" },
			},
			files = {
				exclude = {
					".direnv",
					".git",
					".jj",
					".github",
					".gitlab",
					"bin",
					"node_modules",
					"target",
					"venv",
					".venv",
				},
				-- Avoid Roots Scanned hanging, see https://github.com/rust-lang/rust-analyzer/issues/12613#issuecomment-2096386344
				watcher = "client",
			},
		}
	},
})

vim.lsp.config('codelldb', {})

vim.api.nvim_create_autocmd('BufRead', {
	pattern = "Cargo.toml",
	callback = function(_)
		require 'crates'.setup({
			{
				completion = {
					crates = {
						enabled = true,
					},
				},
				lsp = {
					enabled = true,
					actions = true,
					completion = true,
					hover = true,
				},
			}
		})
	end
})

vim.lsp.enable({ "rust_analyzer", "codelldb" })
