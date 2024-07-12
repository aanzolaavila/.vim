return {
  {
    'zbirenbaum/copilot.lua',
    event = { "InsertEnter", 'BufReadPost' },
    cmd = "Copilot",
    main = 'copilot',
    opts = {
      suggestion = {
        enabled = false,
      },
      panel = {
        enabled = false,
      },
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
        sh = function()
          ---@diagnostic disable-next-line: param-type-mismatch
          if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
            -- disable for .env files
            return false
          end
          return true
        end,
        ["*"] = false,
      },
    },
  },
  {
    'zbirenbaum/copilot-cmp',
    dependencies = {
      'zbirenbaum/copilot.lua',
    },
    main = 'copilot_cmp',
    config = function()
      -- NOTE: this is a workaround to avoid a bug with cmp, must use setup() directly
      require 'copilot_cmp'.setup()

      -- TODO: this should be set on the other one, but not much time available
      vim.cmd([[Copilot disable]]) -- don't want this enabled by default
    end
  },
}
