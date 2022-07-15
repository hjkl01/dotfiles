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
      -- local g = vim.g

      opt.confirm = true
      opt.cmdheight = 1

      -- 折叠
      opt.foldenable = false
      opt.foldmethod = "indent"

      -- 补全增强
      opt.wildmenu = true
      -- 当文件被外部程序修改时，自动加载
      opt.autoread = true
      -- 边输入边搜索
      opt.incsearch = true
      opt.hidden = true

      -- Numbers
      opt.number = true
      opt.numberwidth = 2
      opt.relativenumber = true
      opt.ruler = false

   end,
}

return M
