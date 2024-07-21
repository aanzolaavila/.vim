return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    vim.cmd([[colorscheme catppuccin-latte]])
  end,
  cond = function ()
    local time = os.date("*t")
    return time.hour > 6 and time.hour < 18
  end,
}
