return {
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    version = '^0.9.2',
    build = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    opts = {
      -- [[ Configure Treesitter ]]
      -- See `:help nvim-treesitter`
      configs = {
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = {
          -- required for neovim
          'c',
          'vim',
          'vimdoc',
          'lua',
          -- end required
          'bash',
          'gitignore',
          'gitcommit',
          'make',
        },

        highlight = {
          enable = true,
          disable = function(_, buf)
            local max_size_kb = 500 -- KB
            local max_filesize = max_size_kb * 1024
            ---@diagnostic disable-next-line: undefined-field
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              vim.notify(
                string.format("Disabled Treesitter for the current buffer, as it is bigger than %dKB", max_size_kb),
                vim.log.levels.WARN, { title = "Warning" })
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },

        indent = {
          enable = true,
          disable = { 'python' },
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<C-n>',
            node_incremental = '<C-n>',
            scope_incremental = '<C-m>',
            node_decremental = '<C-b>',
          },
        },
      },
    },
    config = function(_, opts)
      -- vim.print(opts)
      local cfg = require('nvim-treesitter.configs')
      cfg.setup(opts.configs)
      require("nvim-treesitter.install").prefer_git = true
    end
  },
}
