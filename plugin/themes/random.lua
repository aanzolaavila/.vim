function random_theme()
  local dark = {
    "wildcharm",
    "vim",
    "unokai",
    "sorbet",
    "slate",
    "retrobox",
    "pablo",
    "koehler",
    "industry",
    "habamax",
    "darkblue",
    "catppuccin-macchiato",
    "catppuccin-mocha",
    "catppuccin-frappe",
    "catppuccin",
  };

  local light = {
    "peachpuff",
    "lunaperche",
    "catppuccin-latte",
  };

  local themes = dark;
  local time = os.date("*t")
  if time.hour > 6 and time.hour < 18 then
    themes = light;
  end

  local theme = themes[math.random(#themes)];
  local command = 'colorscheme ' .. theme;
  vim.cmd(command)
end

local renew_colorscheme = function()
  -- Workaround to clear remaining colorscheme highlighting
  vim.cmd('colorscheme default')
  vim.cmd('set background=dark')
  random_theme()
end

vim.api.nvim_create_user_command('RenewColorscheme', renew_colorscheme, {})
vim.keymap.set('n', '<localleader>rc', renew_colorscheme, { silent = false, desc = '[r]enew [c]olorscheme' })

random_theme()
