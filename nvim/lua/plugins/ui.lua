local ui_plugins = {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require "plugins.configs.colorscheme"
    end,
  },

  {
    "akinsho/bufferline.nvim",
    lazy = false,
    config = function()
      vim.opt.termguicolors = true
      require("bufferline").setup()
      require("core.utils").load_mappings "bufferline"
    end,
  },
  {
    "feline-nvim/feline.nvim",
    lazy = false,
    config = function()
      -- require("feline").setup()
      require "plugins.configs.feline"
    end,
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
    "nvim-tree/nvim-web-devicons",
    module = "nvim-web-devicons",
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
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
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
}

return ui_plugins
