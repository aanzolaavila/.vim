return {
  'folke/todo-comments.nvim',
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    -- File explorer setup
    require("todo-comments").setup()
  end
}
