local hour = tonumber(os.date("%H"))
local mini_hues = require('mini.hues')

if hour > 6 and hour < 18 then
  vim.o.background = 'light'
  mini_hues.setup({
    background = '#f0f0f0', -- Example light base
    foreground = '#11262d',
    n_hues = 6,
    saturation = 'medium'
  })
else
  vim.o.background = 'dark'
  mini_hues.setup({
    background = '#11262d',
    foreground = '#c0c8cc',
    n_hues = 4,
    saturation = 'low'
  })
end

local function renew_colorscheme()
  vim.cmd('colorscheme randomhue')
end

vim.api.nvim_create_autocmd('VimEnter', { callback = renew_colorscheme })

vim.api.nvim_create_user_command('ColorschemeGetCurrent', function()
  vim.print(vim.inspect(MiniHues.config))
end, {})
vim.api.nvim_create_user_command('RenewColorscheme', renew_colorscheme, {})
vim.keymap.set('n', '<localleader>rc', renew_colorscheme, { silent = false, desc = '[r]enew [c]olorscheme' })
