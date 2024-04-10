return {
  'nvim-lualine/lualine.nvim', -- Fancier statusline
  priority = 1000,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'AndreM222/copilot-lualine',
    {
      'linrongbin16/lsp-progress.nvim',
      main = 'lsp-progress',
      opts = {
        -- show all active lsp clients on the statusline
        -- taken from: https://github.com/linrongbin16/lsp-progress.nvim/wiki/Advanced-Configuration#always-show-lsp-client-names
        -- begin
        client_format = function(client_name, spinner, series_messages)
          if #series_messages == 0 then
            return nil
          end
          return {
            name = client_name,
            body = spinner .. " " .. table.concat(series_messages, ", "),
          }
        end,
        format = function(client_messages)
          --- @param name string
          --- @param msg string?
          --- @return string
          local function stringify(name, msg)
            return msg and string.format("%s %s", name, msg) or name
          end

          local sign = "" -- nf-fa-gear \uf013
          local lsp_clients = vim.lsp.get_clients({ bufnr = 0 })
          local messages_map = {}
          for _, climsg in ipairs(client_messages) do
            messages_map[climsg.name] = climsg.body
          end

          if #lsp_clients > 0 then
            table.sort(lsp_clients, function(a, b)
              ---@diagnostic disable-next-line: undefined-field
              return a.name < b.name
            end)
            local builder = {}
            for _, cli in ipairs(lsp_clients) do
              if
                  type(cli) == "table"
                  ---@diagnostic disable-next-line: undefined-field
                  and type(cli.name) == "string"
                  ---@diagnostic disable-next-line: undefined-field
                  and string.len(cli.name) > 0
              then
                ---@diagnostic disable-next-line: undefined-field
                if messages_map[cli.name] then
                  table.insert(
                    builder,
                    ---@diagnostic disable-next-line: undefined-field
                    stringify(cli.name, messages_map[cli.name])
                  )
                else
                  ---@diagnostic disable-next-line: undefined-field
                  table.insert(builder, stringify(cli.name))
                end
              end
            end
            if #builder > 0 then
              return sign .. " " .. table.concat(builder, ", ")
            end
          end
          return ""
        end, -- end
      }
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
    })

    vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      group = "lualine_augroup",
      pattern = "LspProgressStatusUpdated",
      callback = require("lualine").refresh,
    })
  end
}
