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
    require("gopher").setup {
      commands = {
        go = "go",
        gomodifytags = "gomodifytags",
        impl = "impl",
        iferr = "iferr",
      },
    }
  end
}
