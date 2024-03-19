return {
  'nvim-lualine/lualine.nvim', -- Fancier statusline
  priority = 1000,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    {
      'linrongbin16/lsp-progress.nvim',
      config = function()
        require('lsp-progress').setup()
      end
    },
  },

  config = function()
    require('lualine').setup({
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
          'branch',
          'diff',
          'diagnostics',
        },
        lualine_c = {
          'filename',
          require('lsp-progress').progress,
        },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      extensions = {
        'nvim-tree',
        'trouble',
      },
    })

    vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      group = "lualine_augroup",
      pattern = "LspProgressStatusUpdated",
      callback = require("lualine").refresh,
    })
  end
}
