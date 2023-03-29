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
    config = true,
    setup = function()
      require("core.utils").load_mappings "bufferline"
    end,
  },
  {
    "feline-nvim/feline.nvim",
    lazy = false,
    config = function()
      -- require('feline').setup()
      require "plugins.configs.feline"
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    module = "nvim-web-devicons",
  },
}

return ui_plugins
