require('mini.sessions').setup({
  directory = vim.fn.stdpath('state') .. '/sessions/',
})

local function session_load()
  MiniSessions.read()
end

vim.keymap.set('n', '<leader>ls', session_load, {
  silent = true,
  desc = "[l]oad [s]ession",
})
vim.api.nvim_create_user_command('SessionLoad', session_load, { desc = "Read detected session" })

vim.api.nvim_create_user_command('SessionSave', function()
  MiniSessions.write()
end, { desc = "Write session" })

vim.api.nvim_create_user_command('SessionDelete', function()
  MiniSessions.delete()
end, { desc = "Delete detected session" })

local function session_restart()
  MiniSessions.restart()
end

vim.keymap.set('n', '<leader>rs', session_restart, {
  silent = true,
  desc = "[r]estart vim with [s]ession",
})
vim.api.nvim_create_user_command('SessionRestartVim', session_restart,
  { desc = "Restart Neovim preserving current session" })
