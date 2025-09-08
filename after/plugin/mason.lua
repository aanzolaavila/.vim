local opts = {
	ensure_installed = vim.g.mason_ensure_installed or {}
}

local mason = require 'mason'
mason.setup(opts)
