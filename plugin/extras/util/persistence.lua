local opts = {
  dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),        -- directory where session files are saved
  options = {
		"buffers",
		"curdir",
		"tabpages",
		"winsize",
		"skiprtp",
	}, -- sessionoptions used for saving
  save_empty = false,                                                  -- don't save if there are no open file buffers
}

local persistence = require 'persistence'
persistence.setup(opts)

vim.api.nvim_create_user_command('SessionLoad', function()
  persistence.load()
end, {})

vim.api.nvim_create_user_command('SessionLoadLast', function()
  persistence.load({ last = true })
end, {})

vim.api.nvim_create_user_command('SessionStop', function()
  persistence.stop()
end, {})
