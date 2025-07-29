vim.g.bookmark_no_default_key_mappings = 1
vim.g.bookmark_save_per_working_dir = 1
vim.g.bookmark_auto_save = 1

vim.pack.add({
	{ src = 'https://github.com/MattesGroeger/vim-bookmarks' },
})

vim.keymap.set('n', 'mm', '<CMD>BookmarkToggle<CR>', { desc = 'Add/remove bookmark at current line' })
vim.keymap.set('n', 'mi', '<CMD>BookmarkAnnotate<CR>', { desc = 'Add/edit/remove annotation at current line' })
vim.keymap.set('n', 'mc', '<CMD>BookmarkClear<CR>', { desc = 'Clear bookmarks in current buffer only' })
vim.keymap.set('n', 'mx', '<CMD>BookmarkClearAll<CR>', { desc = 'Clear bookmarks in all buffers' })
