local function toggle_undotree()
	require('undotree').open()
end

vim.keymap.set(
	'n', '<leader>u',
	toggle_undotree,
	{ remap = true }
)
