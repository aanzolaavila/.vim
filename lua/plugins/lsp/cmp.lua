return {
  -- Autocompletion
  'hrsh7th/nvim-cmp',
  event = "InsertEnter",
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'zbirenbaum/copilot-cmp',
    'onsails/lspkind.nvim',
  },
  opts = function(_, opts)
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    local lspkind = require 'lspkind'

    vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

    local has_words_before = function()
      if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
      -- TODO: Check deprecation
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
    end

    local default_opts = {
      -- ensure that the first option is not selected by default
      preselect = cmp.PreselectMode.None,

      -- lspkind
      -- taken from https://github.com/onsails/lspkind.nvim
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol_text', -- show symbol and text annotations
          maxwidth = 50,        -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          -- can also be a function to dynamically calculate max width such as
          -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
          ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          show_labelDetails = true, -- show labelDetails in menu. Disabled by default
          symbol_map = { Copilot = "" }
        })
      },

      -- end lspkind
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.config.disable,
        ['<C-j>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<C-n>'] = vim.schedule_wrap(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end),
        ['<C-p>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
            -- elseif luasnip.jumpable(-1) then
            --   luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },

      sources = {
        { name = 'copilot',  group_index = 2 },
        { name = 'nvim_lsp', group_index = 2 },
        { name = 'luasnip',  group_index = 2 },
        { name = 'buffer',   group_index = 2 },
      },

      sorting = {
        priority_weight = 2,
        comparators = {
          require("copilot_cmp.comparators").prioritize,
          -- Below is the default comparator list and order for nvim-cmp
          cmp.config.compare.offset,
          -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        }
      },

      completion = {
        keyboard_length = 3,
      },

      experimental = {
        ghost_text = true,
      }
    }

    opts = vim.tbl_extend("force", default_opts, opts)
    return opts
  end
}
