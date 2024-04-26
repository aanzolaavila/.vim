vim.filetype.add({
	extension = {
		templ = "templ",
		hcl = "terraform",
	},
	filename = {
		["Tiltfile"] = "starlark",
	},
	pattern = {
		['rfc[0-9]+.txt'] = 'rfc',
		['.*tmux.conf.*'] = 'tmux',
	}
})
