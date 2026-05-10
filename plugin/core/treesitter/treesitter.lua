local function hooks(event)
	-- Use available |event-data|
	local name, kind = event.data.spec.name, event.data.kind
	P(name)
	P(kind)

	if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
		vim.cmd('TSUpdate')
	end
end

vim.api.nvim_create_autocmd('PackChanged', {
	callback = hooks
})
