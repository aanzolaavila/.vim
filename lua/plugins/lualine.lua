return {
  'nvim-lualine/lualine.nvim',   -- Fancier statusline
  config = function()
    require 'config.lualine'.setup()
  end,
}
