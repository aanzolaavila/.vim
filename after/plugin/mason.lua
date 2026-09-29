local opts = {
	ensure_installed = vim.g.mason_ensure_installed or {}
}

local mason = require 'mason'
mason.setup({})


-- Reference: https://www.reddit.com/r/neovim/comments/1k5e568/comment/mokthuk/
local lsps = vim.tbl_map(function(v)
	local access = function()
		return v.resolved_config.cmd[1]
	end
	local status, result = pcall(access)
	if status then
		return result
	else
		return ''
	end
end, vim.lsp._enabled_configs)

local filter = function(array, filterIterator)
	-- filter result to be returned
	local result = {}

	-- iterate over main array
	for key, value in pairs(array) do
		-- call filterIterator
		if filterIterator(value, key, array) then
			-- append the value in filtered result
			table.insert(result, value)
		end
	end

	-- return the filtered result
	return result
end

local tools = filter(vim.tbl_values(lsps), function(v) return v ~= '' end)
if #tools > 0 then
	vim.cmd('MasonInstall ' .. table.concat(tools, ' '))
end
