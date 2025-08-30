local opts = {
	dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- directory where session files are saved
	options = {
		"buffers",
		"curdir",
		"skiprtp",
		"tabpages",
		"winsize",
	},               -- sessionoptions used for saving
	save_empty = false, -- don't save if there are no open file buffers
	branch = true,
}

local persistence = require 'persistence'
persistence.setup(opts)

vim.keymap.set("n", "<leader>ls", persistence.load, { desc = 'Load Session' })

vim.api.nvim_create_user_command('SessionLoad', function()
	persistence.load()
end, { desc = "Load saved session" })

vim.api.nvim_create_user_command('SessionSelect', function()
	persistence.select()
end, { desc = "Select and load a session" })

vim.api.nvim_create_user_command('SessionLoadLast', function()
	persistence.load({ last = true })
end, { desc = "Load last saved session" })

vim.api.nvim_create_user_command('SessionStop', function()
	persistence.stop()
end, { desc = "Stop recording a session when exiting vim" })
