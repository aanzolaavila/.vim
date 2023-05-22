return {
  "ThePrimeagen/refactoring.nvim",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { '<leader>rr', "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", { desc = '[R]refactor' } },
  },
  config = function()
    require("refactoring").setup({
      -- prompt for return type
      prompt_func_return_type = {
        go = true,
        -- cpp = true,
        -- c = true,
        -- java = true,
      },
      -- prompt for function parameters
      prompt_func_param_type = {
        go = true,
        -- cpp = true,
        -- c = true,
        -- java = true,
      },
    })
  end
}
