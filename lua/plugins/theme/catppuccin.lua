return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    local time = os.date("*t")
    local theme = "catppuccin-mocha"

    if time.hour > 6 and time.hour < 18 then
      theme = "catppuccin-macchiato"
    end

    local cmd = "colorscheme " .. theme

    vim.cmd(cmd)
  end,
}
