vim.api.nvim_create_user_command('DeleteFile', function()
  vim.cmd [[ call delete(expand('%')) ]]
end, { desc = "Delete current buffer file, not the buffer" })

vim.api.nvim_create_user_command('DeleteFileAndBuffer', function()
  vim.cmd [[ call delete(expand('%')) | bdelete! ]]
end, { desc = "Delete current buffer and file associated" })
