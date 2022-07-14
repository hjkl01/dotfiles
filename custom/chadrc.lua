local M = {}

local override = require "custom.override"

M.plugins = {

   options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.lspconfig",
      },
   },

   override = {
      ["kyazdani42/nvim-tree.lua"] = override.nvimtree,
      ["nvim-treesitter/nvim-treesitter"] = override.treesitter,
      ["lukas-reineke/indent-blankline.nvim"] = override.blankline,
      ['navarasu/onedark.nvim'] = override.onedark,
   },

   user = require "custom.plugins",
}

M.ui = {
    hl_override = {
    },
    changed_themes = {
        onedark = {},
    },
    theme_toggle = { "onedark", "one_light" },
    -- theme_toggle = { "onedark", "dark" },
    theme = "onedark", -- default theme
    transparency = false,
}

M.mappings = require "custom.mappings"

M.options = {
   user = function()
      local opt = vim.opt
      local g = vim.g

      -- use filetype.lua instead of filetype.vim
      g.did_load_filetypes = 0
      g.do_filetype_lua = 1
      g.toggle_theme_icon = "   "

      opt.confirm = true
      opt.laststatus = 3 -- global statusline
      opt.title = true
      opt.clipboard = "unnamedplus"
      opt.cmdheight = 1
      opt.cul = true -- cursor line

      -- Indentline
      opt.expandtab = true
      opt.shiftwidth = 4
      opt.smartindent = true

      -- 折叠
      opt.foldenable = false
      opt.foldmethod = "indent"

      -- disable tilde on end of buffer: https://github.com/neovim/neovim/pull/8546#issuecomment-643643758
      opt.fillchars = { eob = " " }

      -- 补全增强
      opt.wildmenu = true
      -- 当文件被外部程序修改时，自动加载
      opt.autoread = true
      -- 边输入边搜索
      opt.incsearch = true
      opt.hidden = true
      opt.ignorecase = true
      opt.smartcase = true
      opt.mouse = "a"

      -- Numbers
      opt.number = true
      opt.numberwidth = 2
      opt.relativenumber = true
      opt.ruler = false

      -- disable nvim intro
      opt.shortmess:append "sI"

      opt.signcolumn = "yes"
      opt.splitbelow = true
      opt.splitright = true
      opt.tabstop = 4
      opt.termguicolors = true
      opt.timeoutlen = 400
      opt.undofile = true

      -- interval for writing swap file to disk, also used by gitsigns
      opt.updatetime = 250

      -- go to previous/next line with h,l,left arrow and right arrow
      -- when cursor reaches end/beginning of line
      opt.whichwrap:append "<>[]hl"
      g.mapleader = " "

   end,
}

return M
