---@diagnostic disable: undefined-field
local luasnip = require 'luasnip'
local cmp = require 'cmp'
local lspkind = require 'lspkind'

local opts = {
	-- ensure that the first option is not selected by default
	preselect = cmp.PreselectMode.None,

	-- lspkind
	-- taken from https://github.com/onsails/lspkind.nvim
	formatting = {
		format = lspkind.cmp_format({
			mode = 'symbol_text', -- show symbol and text annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			-- can also be a function to dynamically calculate max width such as
			-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
			ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
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

	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},

	mapping = cmp.mapping.preset.insert {
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.config.disable,
		['<C-j>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<C-n>'] = vim.schedule_wrap(function(_)
			if cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			end
		end),
		['<C-p>'] = cmp.mapping(function(_)
			if cmp.visible() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
			end
		end, { 'i', 's' }),
	},

	sources = cmp.config.sources(
		{
			-- { name = 'copilot' },
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
		}, {
			-- { name = 'buffer' },
		}
	),

	sorting = {
		priority_weight = 2,
		comparators = {
			-- require("copilot_cmp.comparators").prioritize,
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

cmp.setup(opts)
