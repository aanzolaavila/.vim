local opts = {
  options = {
    globalstatus = true,
    fmt = string.lower,
    icons_enabled = true,
    -- theme = 'habamax', -- use default one instead
  },
  sections = {
    lualine_a = {
      'mode',
    },
    lualine_b = {
      {
        'branch',
        fmt = function(s)
          if type(s) ~= "string" then
            return ""
          end
          -- @type integer
          local length = #s
          -- @type string
          local sub = string.sub(s, 1, math.min(30, length))
          return string.lower(sub)
        end,
      },
      'diff',
      {
        'diagnostics',
        sources = { "nvim_diagnostic" },
        symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' }
      }
    },
    lualine_c = {
      'filename',
      require('lsp-progress').progress,
    },
    lualine_x = { 'copilot', 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  extensions = {
    'nvim-tree',
    'trouble',
  },
}

local lualine = require 'lualine'
lualine.setup(opts)

vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
vim.api.nvim_create_autocmd("User", {
  group = "lualine_augroup",
  pattern = "LspProgressStatusUpdated",
  callback = require("lualine").refresh,
})
