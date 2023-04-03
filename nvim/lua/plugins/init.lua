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
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    init = require("core.utils").load_mappings "nvimtree",
    opts = function()
      return require "plugins.configs.nvimtree"
    end,
    config = function(_, opts)
      require("nvim-tree").setup(opts)
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
    "JuanZoran/Trans.nvim",
    -- run = 'bash ./install.sh',
    -- https://github.com/skywind3000/ECDICT-ultimate/releases/download/1.0.0/ecdict-ultimate-sqlite.zip
    keys = {
      -- 可以换成其他你想映射的键
      { "tt", mode = { "n", "x" }, "<Cmd>Translate<CR>", desc = " Translate" },
      { "ts", mode = { "n", "x" }, "<Cmd>TransPlay<CR>", desc = " 自动发音" },

      -- 目前这个功能的视窗还没有做好，可以在配置里将view.i改成hover
      -- { 'mi', '<Cmd>TranslateInput<CR>', desc = ' Translate From Input' },
    },
    dependencies = { "kkharji/sqlite.lua", lazy = true },
    opts = {
      -- your configuration there
    },
    config = function()
      require("Trans").setup {
        db_path = "$HOME/.dotfiles/nvim/ultimate.db",
      }
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
