-- Note: this file needs to be sourced before `telescope.lua`

vim.api.nvim_create_autocmd('PackChanged', {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		local path = ev.data.path
		if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
			vim.system(
				{ 'make' },
				{
					on_stdout = function(_, data) if data then vim.print(data) end end,
					on_stderr = function(_, data) if data then vim.print("ERR:", data) end end,
					on_exit = function(_, code)
						if code == 0 then
							vim.notify("telescope-fzf-native.nvim built successfully!")
						else
							vim.notify("Failed to build telescope-fzf-native.nvim", vim.log.levels.ERROR)
						end
					end,
					cwd = path,
				})
				:wait()
		end
	end
})

vim.pack.add({
	{ src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' },
})
