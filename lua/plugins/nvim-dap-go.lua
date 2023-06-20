return {
  'leoluz/nvim-dap-go',
  dependencies = {
    'mfussenegger/nvim-dap',
  },
  event = 'VeryLazy',
  config = function()
    require('dap-go').setup()

    local dapgo_group = vim.api.nvim_create_augroup('DapGo', { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "go",
      callback = function()
        vim.keymap.set("n", "<leader>dt", function()
          require('dap-go').debug_test()
        end, {
          silent = true,
          buffer = true,
          desc = "[D]ebug [T]est in Go file",
        })
      end,
      group = dapgo_group,
    })
  end
}
