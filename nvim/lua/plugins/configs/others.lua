local M = {}

local load_override = require("core.utils").load_override

M.onedark = function()
  require("onedark").setup {
    -- :help highlight-args
    commentStyle = "italic",
    keywordStyle = "bold",
    functionStyle = "bold",
    -- variableStyle = "bold",
    -- transparent = true,
    -- hideInactiveStatusline = true,
    sidebars = { "qf", "vista_kind", "terminal", "packer" },
  }
end

M.autopairs = function()
  local present1, autopairs = pcall(require, "nvim-autopairs")
  local present2, cmp = pcall(require, "cmp")

  if not (present1 and present2) then
    return
  end

  local options = {
    fast_wrap = {},
    disable_filetype = { "TelescopePrompt", "vim" },
  }

  options = load_override(options, "windwp/nvim-autopairs")
  autopairs.setup(options)

  local cmp_autopairs = require "nvim-autopairs.completion.cmp"
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

M.blankline = function()
  local present, blankline = pcall(require, "indent_blankline")

  if not present then
    return
  end

  local options = {
    indentLine_enabled = 1,
    filetype_exclude = {
      "help",
      "terminal",
      "alpha",
      "packer",
      "lspinfo",
      "TelescopePrompt",
      "TelescopeResults",
      "mason",
      "",
    },
    buftype_exclude = { "terminal" },
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    show_current_context = true,
    show_current_context_start = true,
  }

  options = load_override(options, "lukas-reineke/indent-blankline.nvim")
  blankline.setup(options)
end

M.comment = function()
  local present, nvim_comment = pcall(require, "Comment")

  if not present then
    return
  end

  local options = {}
  options = load_override(options, "numToStr/Comment.nvim")
  nvim_comment.setup(options)
end

M.gitsigns = function()
  local present, gitsigns = pcall(require, "gitsigns")

  if not present then
    return
  end

  local options = {
    signs = {
      add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
      change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
      delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
      topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
      changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
    },
  }

  options = load_override(options, "lewis6991/gitsigns.nvim")
  gitsigns.setup(options)
end

M.devicons = function()
  require("nvim-web-devicons").setup {
    -- your personnal icons can go here (to override)
    -- you can specify color or cterm_color instead of specifying both of them
    -- DevIcon will be appended to `name`
    override = {
      zsh = {
        icon = "",
        color = "#428850",
        cterm_color = "65",
        name = "Zsh",
      },
    },
    -- globally enable default icons (default to false)
    -- will get overriden by `get_icons` option
    default = true,
  }
end

M.packer_init = function()
  return {
    auto_clean = true,
    compile_on_sync = true,
    git = { clone_timeout = 6000 },
    display = {
      working_sym = "ﲊ",
      error_sym = "✗ ",
      done_sym = " ",
      removed_sym = " ",
      moved_sym = "",
      open_fn = function()
        return require("packer.util").float { border = "single" }
      end,
    },
  }
end

return M
