return {
  "olexsmir/gopher.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  build = function()
    vim.cmd [[GoInstallDeps]]
  end,
  config = function()
    require("config.nvim-gopher").setup()
  end
}
