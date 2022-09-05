-- Chadrc overrides this file

local M = {}

M.options = {}

local pluginConfs = require "custom.plugins.configs"

M.plugins = {
  override = {
    ["nvim-treesitter/nvim-treesitter"] = pluginConfs.treesitter,
    ["kyazdani42/nvim-tree.lua"] = pluginConfs.nvimtree,
    ["williamboman/mason.nvim"] = pluginConfs.mason,
  },

  remove = {},

  user = {
    ['voldikss/vim-translator'] = {
        config = function()
            vim.g.translator_default_engines = { 'haici', 'youdao', 'bing' }
        end,
    },

    ['navarasu/onedark.nvim'] = {
        config = function()
            require("custom.plugins.configs").onedark()
        end,
    },

    ['sbdchd/neoformat'] = {},

    ["neovim/nvim-lspconfig"] = {
        config = function()
          require "custom.plugins.lsp_config"
        end,
    },

    ["jose-elias-alvarez/null-ls.nvim"] = {
      after = "nvim-lspconfig",
      config = function()
         require "custom.plugins.null-ls"
      end,
    },

  },
}

-- check core.mappings for table structure
-- M.mappings = require "core.mappings"
M.mappings = require "custom.mappings"

return M
