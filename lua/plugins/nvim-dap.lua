return {
  'mfussenegger/nvim-dap',
  event = 'VeryLazy',
  config = function()
    vim.keymap.set("n", "<F5>", function() require('dap').continue() end, { silent = true })
    vim.keymap.set("n", "<F1>", function() require('dap').step_over() end, { silent = true })
    vim.keymap.set("n", "<F2>", function() require('dap').step_into() end, { silent = true })
    vim.keymap.set("n", "<F3>", function() require('dap').step_out() end, { silent = true })
    vim.keymap.set("n", "<leader>b", function() require('dap').toggle_breakpoint() end, { silent = true })
    vim.keymap.set("n", "<leader>B",
      function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { silent = true })
    vim.keymap.set("n", "<leader>lp",
      function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { silent = true })
  end
}
