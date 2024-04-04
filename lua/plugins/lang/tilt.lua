return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre Tiltfile*" },
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "starlark",
      })

      local pattern = "Tiltfile*"
      local cmd = { 'tilt', 'lsp', 'start' }
      -- Add files/folders here that indicate the root of a project
      local root_markers = { ".git", "Tiltfile" }
      -- Change to table with settings if required
      local settings = vim.empty_dict()

      vim.api.nvim_create_autocmd("BufRead", {
        pattern = pattern,
        callback = function(args)
          local match = vim.fs.find(root_markers, { path = args.file, upward = true })[1]
          local root_dir = match and vim.fn.fnamemodify(match, ":p:h") or nil

          vim.cmd [[ setlocal filetype=starlark ]]

          vim.lsp.start({
            name = "tiltlsp",
            cmd = cmd,
            root_dir = root_dir,
            settings = settings,
          })
        end,
      })
    end,
  },
}
