return {
  'folke/todo-comments.nvim',
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    -- File explorer setup
    require("todo-comments").setup()
  end
}
