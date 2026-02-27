# Neovim Customizations

This README documents the modifications in this repository relative to a
vanilla LazyVim setup. It intentionally focuses only on changed behavior.

## What Is Customized

- Explorer behavior and keybinding ergonomics
- Git commit-to-files navigation flow
- Amp IDE messaging/reference integration
- Editing defaults and save-time hygiene
- Markdown and Svelte language/tooling behavior

## Explorer Customizations

Defined in `lua/plugins/explorer.lua`.

- Snacks Explorer is configured as a right-side sidebar.
- Explorer preview is disabled in sidebar mode.
- `\\` remaps to `<leader>fE` for quick explorer toggle.

## Git Workflow Customizations

Defined in `lua/plugins/snacks.lua`.

- `<leader>ge` opens a commit picker (`Snacks.picker.git_log`).
- Selecting a commit shells out to `git show --name-only --pretty=format:`.
- A second picker is opened from the commit result to jump directly to changed
  files.
- `<leader>gc` runs `pnpm fix` in an interactive bottom terminal.
- `<leader>t` toggles the Snacks terminal.

## Amp IDE Customizations

Defined in `lua/plugins/amp.lua`.

- `sourcegraph/amp.nvim` is loaded eagerly with `auto_start = true`.
- Custom keymaps and commands are added for prompt composition and message
  sending.
- A macOS helper sends `ctrl+opt+l` shortly after prompt inserts to focus the
  Amp pane.

### Amp Keymaps

- `<leader>aa` (normal): add `@file[#Lx[-Ly]]` reference to prompt
- `<leader>aa` (visual): add selected file range reference to prompt
- `<leader>am`: prompt and send message to Amp
- `<leader>ab`: send current buffer contents to Amp
- `<leader>as` (visual): add selected text to Amp prompt

### Amp User Commands

- `:AmpPromptRef` (range-aware)
- `:AmpSend {message}`
- `:AmpSendBuffer`
- `:AmpPromptSelection` (range-aware)

## Editing Defaults and Autocmds

Defined in `lua/config/options.lua`, `lua/config/keymaps.lua`, and
`lua/config/autocmds.lua`.

- `maplocalleader` is set to `|`.
- Snacks animations are disabled via `vim.g.snacks_animate = false`.
- Tab settings are standardized to 2 spaces.
- Visual mode `Shift-j` / `Shift-k` moves selected lines down/up.
- `<leader>r` opens `:%s/` for fast substitution.
- On save, trailing whitespace is trimmed while preserving cursor position.
- In `gitcommit` buffers:
  - `colorcolumn = 50,72`
  - `textwidth = 72`
  - `spell = true`

## Language/Tooling Overrides

### Markdown

Defined in `lua/plugins/markdown.lua`.

- Markdown formatters are cleared from `conform.nvim`.
- Markdown linters are cleared from `nvim-lint`.

### Svelte LSP

Defined in `lua/plugins/svelte.lua`.

- Svelte root resolution prefers `svelte.config.js/mjs/cjs`.
- If none exists, fallback root is nearest `package.json`, `.git`, or cwd.

## Quick Keymap Reference

- `\\`: explorer toggle
- `<leader>fE`: explorer toggle
- `<leader>t`: terminal toggle
- `<leader>gc`: run `pnpm fix`
- `<leader>ge`: commit picker → changed files picker
- `<leader>aa`: Amp file/range reference (normal + visual)
- `<leader>am`: Amp message input/send
- `<leader>ab`: send current buffer to Amp
- `<leader>as`: send visual selection to Amp prompt
- `<leader>r`: open `:%s/` (find and replace)

## Notes

- `lua/plugins/example.lua` is disabled (`if true then return {} end`) and is
  not part of runtime behavior.

---

Amp thread: https://ampcode.com/threads/T-019c9e87-8808-7659-9914-0753e3754a55
