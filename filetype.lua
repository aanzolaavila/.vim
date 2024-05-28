vim.filetype.add({
	extension = {
		templ = "templ",
		tf = "terraform",
		zsh = "sh",
	},
	filename = {
		["Tiltfile"] = "starlark",
	},
	pattern = {
		['rfc[0-9]+.txt'] = 'rfc',
		['.*tmux.conf.*'] = 'tmux',
	}
})
