vim.pack.add({
})

vim.keymap.set(
	'n', '<leader>u',
	':UndotreeShow<CR>:UndotreeFocus<CR>',
	{ remap = true }
)
