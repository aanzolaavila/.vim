return {
  {
    'mfussenegger/nvim-dap',
    event = 'VeryLazy',
    config = function()
      local dap = require("dap")

      vim.keymap.set("n", "<localleader>dc", function() dap.continue() end, { silent = true })
      vim.keymap.set("n", "<localleader>dn", function() dap.step_over() end, { silent = true })
      vim.keymap.set("n", "<localleader>di", function() dap.step_into() end, { silent = true })
      vim.keymap.set("n", "<localleader>do", function() dap.step_out() end, { silent = true })
      vim.keymap.set("n", "<localleader>db", function() dap.toggle_breakpoint() end, { silent = true })
      vim.keymap.set("n", "<localleader>dB",
        function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { silent = true })
      vim.keymap.set("n", "<localleader>dp",
        function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { silent = true })
      vim.keymap.set("n", "<localleader>dC", function()
        dap.clear_breakpoints()
        require("notify")("Breakpoints cleared", "warn")
      end)
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    event = 'VeryLazy',
    dependencies = {
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")

      -- dap
      vim.keymap.set("n", "<localleader>dl", require("dap.ui.widgets").hover)

      -- dapui
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    event = 'VeryLazy',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      require("nvim-dap-virtual-text").setup()
    end
  }
}
