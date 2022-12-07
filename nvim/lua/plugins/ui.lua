local plugins_ui = {
  ["smiteshp/nvim-navic"] = {},
  ["utilyre/barbecue.nvim"] = {
    config = function()
      require("barbecue").setup()
    end,
  },

  ["kyazdani42/nvim-web-devicons"] = {
    module = "nvim-web-devicons",
  },

  ["kyazdani42/nvim-tree.lua"] = {
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require "plugins.configs.nvimtree"
    end,
    setup = function()
      require("core.utils").load_mappings "nvimtree"
    end,
  },

  ["folke/tokyonight.nvim"] = {
    config = function()
      require "plugins.configs.colorscheme"
      vim.cmd [[ colorscheme tokyonight ]]
    end,
  },

  ["akinsho/bufferline.nvim"] = {
    config = function()
      require("bufferline").setup {}
    end,
  },

  ["feline-nvim/feline.nvim"] = {
    config = function()
      -- require('feline').setup()
      require "plugins.configs.feline"
    end,
  },

  ["nvim-telescope/telescope.nvim"] = {
    cmd = "Telescope",
    config = function()
      require "plugins.configs.telescope"
    end,
    setup = function()
      require("core.utils").load_mappings "telescope"
    end,
  },
}

return plugins_ui
