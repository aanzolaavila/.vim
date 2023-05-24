return {
  'folke/twilight.nvim',
  event = "VeryLazy",
  config = function()
    require 'twilight'.setup()
  end
}
