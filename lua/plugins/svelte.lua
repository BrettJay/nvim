return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        svelte = {
          root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            if vim.uv.fs_stat(fname) == nil then
              return
            end
            local svelte_root =
              vim.fs.root(bufnr, { "svelte.config.js", "svelte.config.mjs", "svelte.config.cjs" })
            if svelte_root then
              on_dir(svelte_root)
              return
            end
            local fallback = vim.fs.root(bufnr, { "package.json", ".git" }) or vim.fn.getcwd()
            on_dir(fallback)
          end,
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      if not vim.g.amp_monorepo then
        return
      end

      opts.servers = opts.servers or {}
      if opts.servers.tsgo then
        opts.servers.tsgo = vim.tbl_deep_extend("force", opts.servers.tsgo, {
          mason = false,
        })
      end

      if opts.servers.tailwindcss then
        opts.servers.tailwindcss = vim.tbl_deep_extend("force", opts.servers.tailwindcss, {
          filetypes_exclude = {
            "javascript",
            "javascriptreact",
            "markdown",
            "typescript",
            "typescriptreact",
          },
        })
      end
    end,
  },
}
