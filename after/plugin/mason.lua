local opts = {
	ensure_installed = vim.g.mason_ensure_installed or {}
}

require 'mason'.setup(opts)
