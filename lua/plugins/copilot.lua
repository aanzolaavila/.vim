return {
  'zbirenbaum/copilot.lua',
  event = "InsertEnter",
  cmd = "Copilot",
  config = function()
    require('copilot').setup({
      suggestion = { enabled = true },
      panel = { enabled = true },
      filetype = {
        javascript = true,
        typescript = true,
        javascriptreact = true,
        typescriptreact = true,
        rust = true,
        c = true,
        cpp = true,
        go = true,
        python = true,
        lua = true,
        c_sharp = true,
        ["*"] = false,
      },
    })
  end
}
