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
  -- file managing , picker etc
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle" },
    init = require("core.utils").load_mappings "nvimtree",
    config = function()
      require "plugins.configs.nvimtree"
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    init = require("core.utils").load_mappings "telescope",
    opts = function()
      return require "plugins.configs.telescope"
    end,
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)

      -- load extensions
      -- for _, ext in ipairs(opts.extensions_list) do
      --   telescope.load_extension(ext)
      -- end
    end,
  },
  -- Only load whichkey after all the gui
  {
    "folke/which-key.nvim",
    keys = { "<leader>", '"', "'", "`", "g" },
    init = require("core.utils").load_mappings "whichkey",
    opts = function()
      return require "plugins.configs.whichkey"
    end,
    config = function(_, opts)
      require("which-key").setup(opts)
    end,
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

local config = require("core.utils").load_config()

-- lazy_nvim startup opts
local lazy_config = vim.tbl_deep_extend("force", require "plugins.configs.lazy_nvim", config.lazy_nvim)

require("lazy").setup(default_plugins, lazy_config)
