# Neovim config (vim.pack)

This config uses Neovim's built-in package manager `vim.pack` (Neovim >= 0.12).

## Layout

- Entry point: `init.lua`
- Core options / autocmds / keymaps: `lua/config/`
- Plugin source list (single source of truth): `lua/config/pack.lua`
- Plugin setup modules: `lua/plugins/*.lua`, driven by `lua/plugins/init.lua`
- Lockfile: `nvim-pack-lock.json` (repo root, symlinked from `~/.config/nvim`)

`lua/plugins/init.lua` caches the module list in
`~/.cache/nvim/dotfiles_plugins.json` and only re-globs when `lua/plugins/` changes.

## Loading strategy

- **Eager on startup**: core config modules plus most `lua/plugins/*.lua` setup functions.
- **On-demand via `require("config.pack").load(...)`**:
  - `bigfile.nvim`
  - `telescope.nvim`
  - `neo-tree.nvim`
  - `trouble.nvim`
  - `persistence.nvim`
  - `vim-translator`

## Plugins

- **Core / shared**: `plenary.nvim`, `nvim-web-devicons`, `nui.nvim`
- **UI**: `catppuccin`, `lualine.nvim`, `bufferline.nvim`, `noice.nvim`, `which-key.nvim`
- **Navigation**: `flash.nvim`, `neo-tree.nvim`
- **LSP / syntax / diagnostics**: `mason.nvim`, `mason-lspconfig.nvim`, `nvim-lspconfig`, `nvim-treesitter`, `nvim-treesitter-textobjects`, `nvim-lint`, `trouble.nvim`
- **Editing / completion / snippets**: `blink.cmp`, `conform.nvim`, `friendly-snippets`, `mini.nvim`, `bigfile.nvim`
- **Search / project tools**: `telescope.nvim`
- **Git / session**: `gitsigns.nvim`, `vim-fugitive`, `diffview.nvim`, `persistence.nvim`
- **AI / language helpers**: `lazydev.nvim`
- **Utility**: `vim-translator`, `undotree`

## Treesitter

`nvim-treesitter` is the new `main`-branch API, so:

- Parsers are declared in `ensure_installed` inside `lua/plugins/treesitter.lua` and
  installed with `require("nvim-treesitter").install(...)`.
- Highlighting is started per buffer via a `FileType` autocmd calling
  `vim.treesitter.start()` (files > 100 KB are skipped).
- Text objects (`af` / `if` / `ac` / `ic`) come from `nvim-treesitter-textobjects`.
- Installing parsers requires the `tree-sitter` CLI (`brew install tree-sitter-cli`)
  and network access to GitHub.

## Maintenance notes

- `lua/config/pack.lua` is authoritative. Anything installed but not listed there is
  considered leftover; `nvim-pack-lock.json` is kept in sync with it.
- `blink.cmp` uses `fuzzy.implementation = "prefer_rust_with_warning"`; the prebuilt
  fuzzy binary is downloaded automatically on supported platforms.

Useful commands:

- Update plugins: `:lua vim.pack.update()`
- Inspect installed plugins: `:lua vim.print(vim.pack.get())`
- blink.cmp health / build: `:checkhealth blink.cmp`, `:BlinkCmp build`