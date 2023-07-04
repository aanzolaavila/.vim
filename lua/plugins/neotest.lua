return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",

    -- Adapters
    'nvim-neotest/neotest-go',
  },

  config = function()
    vim.api.nvim_create_user_command('TestNearest', function()
      require("neotest").run.run()
    end, {})

    vim.api.nvim_create_user_command('TestStop', function()
      require("neotest").run.stop()
    end, {})

    vim.api.nvim_create_user_command('TestFile', function()
      require("neotest").run.run(vim.fn.expand("%"))
    end, {})

    vim.api.nvim_create_user_command('TestSuite', function()
      require('neotest').run.run(vim.fn.getcwd())
    end, {})

    -- get neotest namespace (api call creates or returns namespace)
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message =
              diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          return message
        end,
      },
    }, neotest_ns)

    require('neotest').setup({
      adapters = {
        require("neotest-go")({
          args = {
            '-covermode=atomic',
            '-count=1',
            '-race',
            '-timeout=10m',
            '-shuffle=on'
          },
        }),
      }
    })
  end
}
