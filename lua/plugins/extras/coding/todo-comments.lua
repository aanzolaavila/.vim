return {
  'folke/todo-comments.nvim',
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    highlight = {
      before = "fg",
      keyword = "bg",
      pattern = [[.*<(KEYWORDS)\s*]],
    },

    search = {
      command = 'rg',
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--case-sensitive",
      },
      pattern = [[\b(KEYWORDS)\b]],
    }
  },
}
