-- All plugins have lazy=true by default,to load a plugin on startup just lazy=false
-- List of all default plugins & their definitions
local default_plugins = {
  ["lewis6991/impatient.nvim"] = {
    config = function()
      require "impatient"
    end,
  },
  "nvim-lua/plenary.nvim",
  {
    "smiteshp/nvim-navic",
    lazy = false,
  },
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
    init = require("core.utils").load_mappings "translate",
    config = function()
      vim.g.translator_default_engines = { "haici", "bing" }
    end,
  },
}

local ui_plugins, _ = require "plugins.ui"
for _, v in pairs(ui_plugins) do
  table.insert(default_plugins, v)
end

local code_plugins, _ = require "plugins.code"
for _, v in pairs(code_plugins) do
  table.insert(default_plugins, v)
end

-- local config = require("core.utils").load_config()

-- lazy_nvim startup opts
-- local lazy_config = vim.tbl_deep_extend("force", require "plugins.configs.lazy_nvim", config.lazy_nvim)
local lazy_config = require "plugins.configs.lazy_nvim" -- config for lazy.nvim startup options

require("lazy").setup(default_plugins, lazy_config)
