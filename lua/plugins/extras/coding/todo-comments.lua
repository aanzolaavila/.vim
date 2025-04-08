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
  keys = {
    { "]t",         function() require("todo-comments").jump_next() end,                  desc = "Next Todo Comment" },
    { "[t",         function() require("todo-comments").jump_prev() end,                  desc = "Previous Todo Comment" },
    { "<leader>st", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME initial_mode=normal<cr>", desc = "[S]earch [t]odos (TODO,FIX,FIXME)" },
    { "<leader>sT", "<cmd>TodoTelescope initial_mode=normal<cr>",                         desc = "[S]earch all [T]odos" },
  }
}
