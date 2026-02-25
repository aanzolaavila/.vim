---@diagnostic disable: undefined-field
local luasnip = require 'luasnip'
local cmp = require 'cmp'
local lspkind = require 'lspkind'

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

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

	mapping = {
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<Tab>"] = cmp.mapping(function(fallback)
			if luasnip.locally_jumpable(1) and luasnip.in_snippet() then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { 'i', 's' }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if luasnip.locally_jumpable(-1) and luasnip.in_snippet() then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
		["<C-j>"] = cmp.mapping {
			i = function()
				if cmp.visible() and cmp.get_active_entry() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
				end
			end,
			s = cmp.mapping.confirm({ select = true }),
			c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
		},
		["<C-n>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			else
				fallback()
			end
		end, { 'i', 's' }),
		["<C-p>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
			else
				fallback()
			end
		end, { 'i', 's' }),
		["<C-l>"] = cmp.mapping(function(fallback)
			if luasnip.choice_active() then
				luasnip.change_choice(1)
			else
				fallback()
			end
		end, { 'i', 's' }),
		["<C-h>"] = cmp.mapping(function(fallback)
			if luasnip.choice_active() then
				luasnip.change_choice(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	},

	sources = cmp.config.sources(
		{
			-- { name = 'copilot' },
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
		}, {
			{ name = 'buffer' },
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
		completeopt = "menu,menuone,noinsert,noselect",
	},
}

cmp.setup(opts)
