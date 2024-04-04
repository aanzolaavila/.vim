return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "starlark",
      })

      vim.api.nvim_create_autocmd("BufReadPost", {
        pattern = "Tiltfile*",
        callback = function(args)
          -- Add files/folders here that indicate the root of a project
          local root_markers = { ".git", "Tiltfile" }
          local match = vim.fs.find(root_markers, { path = args.file, upward = true })[1]
          local root_dir = match and vim.fn.fnamemodify(match, ":p:h") or nil

          local cmd = { 'tilt', 'lsp', 'start' }

          -- Change to table with settings if required
          local settings = vim.empty_dict()

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
