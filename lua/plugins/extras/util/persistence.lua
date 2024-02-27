return {
  "folke/persistence.nvim",
  event = "VeryLazy",
  config = function()
    require("persistence").setup({
      dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),        -- directory where session files are saved
      options = { "buffers", "curdir", "tabpages", "winsize", "skiprtp" }, -- sessionoptions used for saving
      save_empty = false,                                                  -- don't save if there are no open file buffers
    })

    vim.api.nvim_create_user_command('SessionLoad', function()
      require("persistence").load()
    end, {})

    vim.api.nvim_create_user_command('SessionLoadLast', function()
      require("persistence").load({ last = true })
    end, {})

    vim.api.nvim_create_user_command('SessionStop', function()
      require("persistence").stop()
    end, {})
  end
}
