local opts = {
  use_default_keymaps = false,
  max_join_length = 500,
}
local treesj = require "treesj"
treesj.setup(opts)

vim.keymap.set(
	'n', '<leader>m',
	treesj.toggle,
	{ desc = 'toggle node under cursor (split if one-line and join if multiline)' }
)
vim.keymap.set(
	'n', '<leader>M',
	function()
			treesj.toggle({ split = { recursive = true } })
		end,
	{ desc = 'toggle node under cursor (recursively)' }
)
