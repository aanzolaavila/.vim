vim.filetype.add({
	extension = {
		templ = "templ",
	},
	filename = {
		["Tiltfile"] = "starlark",
	},
	pattern = {
		['rfc[0-9]+.txt'] = 'rfc',
	}
})
