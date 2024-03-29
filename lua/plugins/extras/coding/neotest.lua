return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter"
  },

  config = function()
    local neotest = require('neotest')
    vim.api.nvim_create_user_command('TestNearest', function()
      neotest.run.run()
    end, {})
    vim.api.nvim_create_user_command('TestNearestDebug', function()
      neotest.run.run({ strategy = "dap" })
    end, {})

    vim.api.nvim_create_user_command('TestLast', function()
      neotest.run.run_last()
    end, {})
    vim.api.nvim_create_user_command('TestLastDebug', function()
      neotest.run.run_last({ strategy = "dap" })
    end, {})

    vim.api.nvim_create_user_command('TestStop', function()
      neotest.run.stop()
    end, {})

    vim.api.nvim_create_user_command('TestFile', function()
      neotest.run.run(vim.fn.expand("%"))
    end, {})
    vim.api.nvim_create_user_command('TestFileDebug', function()
      neotest.run.run({ vim.fn.expand("%"), strategy = "dap" })
    end, {})

    vim.api.nvim_create_user_command('TestSuite', function()
      neotest.run.run(vim.fn.getcwd())
    end, {})

    vim.api.nvim_create_user_command('TestOutput', function()
      neotest.output.open({ enter = true })
    end, {})

    vim.api.nvim_create_user_command('TestOutputPanel', function()
      neotest.output_panel.toggle()
    end, {})

    vim.api.nvim_create_user_command('TestOutputPanelClose', function()
      neotest.output_panel.close()
    end, {})

    vim.api.nvim_create_user_command('TestOutputPanelClear', function()
      neotest.output_panel.clear()
    end, {})

    vim.api.nvim_create_user_command('TestOutputPanelReset', function()
      neotest.output_panel.clear()
      neotest.output_panel.close()
    end, {})

    vim.api.nvim_create_user_command('TestSummary', function()
      neotest.summary.toggle()
    end, {})

    vim.api.nvim_create_user_command('TestWatch', function()
      neotest.watch.watch()
    end, {})
    vim.api.nvim_create_user_command('TestWatchStop', function()
      neotest.watch.stop()
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
  end
}
