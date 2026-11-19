local opts = {
	dir = vim.fn.stdpath("state") .. "/sessions/", -- directory where session files are saved
	-- minimum number of file buffers that need to be open to save
	-- Set to 0 to always save
	need = 1,
	branch = true, -- use git branch to save session
}

local persistence = require('persistence')
persistence.setup(opts)

vim.keymap.set('n', '<leader>ls', persistence.load, { silent = true, desc = "[l]oad [s]ession" })
vim.api.nvim_create_user_command('SessionLoad', persistence.load, { desc = "Load session" })
vim.api.nvim_create_user_command('SessionLoadLast', function() persistence.load({ last = true }) end,
	{ desc = "Load latest session" })
vim.api.nvim_create_user_command('SessionSelect', persistence.select, { desc = "Select session to restore" })
vim.api.nvim_create_user_command('SessionStop', persistence.stop, { desc = "Stop tracking session" })

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local cwd = vim.fs.normalize(vim.fn.getcwd())

		local denylist = {
			vim.fs.normalize("~"),
			vim.fs.normalize("~/wiki"),
		}

		if not vim.tbl_contains(denylist, cwd) then
			local choice = vim.fn.confirm("Load session from " .. cwd .. "?", "&Yes\n&No", 2)
			if choice == 1 then
				persistence.load()
			end
		end
	end,
	nested = true,
})
