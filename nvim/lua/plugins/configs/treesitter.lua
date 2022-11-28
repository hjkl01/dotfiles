local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
  return
end

local options = {
  ensure_installed = {
    "lua",
    "python",
    "bash",
    "javascript",
    "markdown",
    -- "go",
    -- "typescript",
  },

  sync_install = false,
  auto_install = true,
  -- ignore_install = { "javascript" },

  highlight = {
    enable = true,
    -- disable = { "c", "rust" },
    use_languagetree = true,
  },
  additional_vim_regex_highlighting = true,
}

-- check for any override
options = require("core.utils").load_override(options, "nvim-treesitter/nvim-treesitter")

treesitter.setup(options)
