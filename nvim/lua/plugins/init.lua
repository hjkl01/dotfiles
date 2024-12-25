-- All plugins have lazy=true by default,to load a plugin on startup just lazy=false
-- List of all default plugins & their definitions
local default_plugins = {
  -- "nvim-lua/plenary.nvim",
  {
    "echasnovski/mini.nvim",
    lazy = false,
    config = function()
      require "plugins.configs.mini"
    end,
  },
  {
    "voldikss/vim-translator",
    cmd = "Translate",
    lazy = false,
    init = require("utils").load_mappings "translate",
    config = function()
      vim.g.translator_default_engines = { "haici", "bing" }
    end,
  },
}

local ui_plugins, _ = require "plugins.ui"
local code_plugins, _ = require "plugins.code"
local dev_plugins, _ = require "plugins.dev"
local other_plugins = { ui_plugins, code_plugins, dev_plugins }

for _, op in pairs(other_plugins) do
  for _, v in pairs(op) do
    table.insert(default_plugins, v)
  end
end

local lazy_config = require "plugins.configs.lazy_nvim" -- config for lazy.nvim startup options

require("lazy").setup(default_plugins, lazy_config)
