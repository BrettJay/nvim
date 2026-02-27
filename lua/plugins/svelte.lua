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
}
