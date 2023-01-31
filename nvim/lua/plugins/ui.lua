local plugins_ui = {
  ["smiteshp/nvim-navic"] = {},
  -- ["utilyre/barbecue.nvim"] = {
  --   config = function()
  --     require("barbecue").setup()
  --   end,
  -- },

  ["nvim-tree/nvim-web-devicons"] = {
    module = "nvim-web-devicons",
  },

  ["nvim-tree/nvim-tree.lua"] = {
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
    end,
  },

  ["akinsho/bufferline.nvim"] = {
    config = function()
      require("bufferline").setup {}
    end,
    setup = function()
      require("core.utils").load_mappings "bufferline"
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

  ["folke/which-key.nvim"] = {
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
        window = {
          border = "shadow", -- none/single/double/shadow
        },
      }
    end,
    setup = function()
      require("core.utils").load_mappings "whichkey"
    end,
  },
}

return plugins_ui
