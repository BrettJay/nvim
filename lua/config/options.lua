-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.maplocalleader = "|"
vim.g.snacks_animate = false
local startup_cwd = vim.fs.normalize(vim.uv.cwd() or ".")
vim.g.startup_cwd = startup_cwd

local function has_child(root, name)
  return vim.uv.fs_stat(vim.fs.joinpath(root, name)) ~= nil
end

local function is_amp_monorepo(cwd)
  local root = vim.fs.root(cwd, { "pnpm-workspace.yaml", ".git" })
  return root
    and has_child(root, "cli")
    and has_child(root, "core")
    and has_child(root, "server")
    and has_child(root, "thread-actors")
end

vim.g.amp_monorepo = is_amp_monorepo(startup_cwd)
if vim.g.amp_monorepo then
  vim.g.lazyvim_ts_lsp = "tsgo"
end

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
