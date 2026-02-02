return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      preset = {
        header = [[]],
      },
    },
  },
  keys = {
    {
      "<leader>t",
      function()
        Snacks.terminal.toggle()
      end,
      desc = "Toggle terminal",
    },
    {
      "<leader>gc",
      function()
        Snacks.terminal("zsh -ic 'pnpm fix'", {
          cwd = vim.fn.getcwd(),
          win = { position = "bottom", height = 0.3 },
          interactive = true,
        })
      end,
      desc = "Run check",
    },
    {
      "<leader>ge",
      function()
        Snacks.picker.git_log({
          confirm = function(picker, item)
            if not item then
              return
            end

            local commit = item.commit or item.hash or item.oid
            if not commit then
              return
            end

            picker:close()

            vim.schedule(function()
              local files = {}
              for _, f in ipairs(vim.fn.systemlist("git show --name-only --pretty=format: " .. commit)) do
                if f ~= "" then
                  table.insert(files, { text = f, file = f, pos = { 1, 0 } })
                end
              end

              Snacks.picker.pick({
                items = files,
                format = "file",
                title = "Files: " .. commit:sub(1, 7),
                confirm = "jump",
              })
            end)
          end,
        })
      end,
      desc = "Git: Explore commits → files",
    },
  },
}
