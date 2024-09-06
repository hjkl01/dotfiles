local ui_plugins = {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require "plugins.configs.colorscheme"
    end,
  },

  -- file managing , picker etc
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    init = require("utils").load_mappings "neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      require "plugins.configs.neotree"
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    init = require("utils").load_mappings "telescope",
    opts = function()
      return require "plugins.configs.telescope"
    end,
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)

      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },

  -- Only load whichkey after all the gui
  {
    "folke/which-key.nvim",
    keys = { "<leader>", '"', "'", "`", "g" },
    init = require("utils").load_mappings "whichkey",
    opts = function()
      return require "plugins.configs.whichkey"
    end,
    config = function(_, opts)
      require("which-key").setup(opts)
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      messages = {
        enabled = false,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function(_, opts)
      require("noice").setup(opts)
    end,
  },
}

return ui_plugins
