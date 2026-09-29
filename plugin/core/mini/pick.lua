require('mini.pick').setup({
	options = {
		content_from_bottom = true,
		use_cache = true,
	}
})

vim.keymap.set('n', '<leader><space>', function()
		local status, result = pcall(MiniPick.builtin.resume)
		if not status then
			vim.notify("No picker active", vim.log.levels.ERROR)
		end
	end,
	{ desc = '[ ] resume from active picker' })

vim.keymap.set('n', '<leader>sf', function() MiniPick.builtin.files() end, { desc = '[s]earch [f]iles' })
vim.keymap.set('n', '<leader>sg', function() MiniPick.builtin.grep_live() end, { desc = '[s]earch by [g]rep live' })
vim.keymap.set('n', '<leader>sh', function() MiniPick.builtin.help() end, { desc = '[s]earch [h]elp' })
vim.keymap.set('n', '<leader>sb', function() MiniPick.builtin.buffers() end, { desc = '[s]earch [b]uffers' })
vim.keymap.set('n', '<leader>sw', function()
	local pattern = vim.fn.expand('<cword>')
	if #pattern == 0 then
		vim.notify("No word selected", vim.log.levels.WARN)
		return
	end

	MiniPick.builtin.grep({
		pattern = pattern,
	})
end, { desc = '[s]earch current [w]ord' })

-- Extra pickers
require('mini.extra').setup() -- offers more pickers

vim.keymap.set('n', '<leader>sm', function() MiniExtra.pickers.manpages() end, { desc = '[s]earch [m]an pages' })

vim.keymap.set('n', '<leader>sq', function()
	MiniExtra.pickers.list { scope = 'quickfix' }
end, { desc = '[s]earch [q]uickfix list' })

vim.keymap.set('n', '<leader>sl', function()
	MiniExtra.pickers.list { scope = 'location' }
end, { desc = '[s]earch [l]ocation list' })

vim.keymap.set('n', '<leader>sj', function()
	MiniExtra.pickers.list { scope = 'jump' }
end, { desc = '[s]earch [j]umplist' })

vim.keymap.set('n', '<leader>sC', function()
	MiniExtra.pickers.list { scope = 'change' }
end, { desc = '[s]earch [C]hangelist' })

vim.keymap.set('n', '<leader>sM', function() MiniExtra.pickers.marks() end, { desc = '[s]earch [M]arks' })
vim.keymap.set('n', '<leader>sd', function() MiniExtra.pickers.diagnostic() end, { desc = '[s]earch [d]iagnostics' })
vim.keymap.set('n', '<leader>sk', function() MiniExtra.pickers.keymaps() end, { desc = '[s]earch [k]eymaps' })
vim.keymap.set('n', '<leader>sc', function() MiniExtra.pickers.commands() end, { desc = '[s]earch [c]ommands' })
vim.keymap.set('n', '<leader>sr', function() MiniExtra.pickers.registers() end, { desc = '[s]earch [r]egisters' })
vim.keymap.set('n', '<leader>so', function() MiniExtra.pickers.options() end, { desc = '[s]earch [o]ptions' })
vim.keymap.set('n', '<leader>sH', function() MiniExtra.pickers.history() end, { desc = '[s]earch [H]istory' })
