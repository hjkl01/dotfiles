local plugins_code = {

  -- lsp stuff
  ["neovim/nvim-lspconfig"] = {
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "nvim-lspconfig"
    end,
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },

  ["williamboman/mason-lspconfig.nvim"] = {},

  ["williamboman/mason.nvim"] = {
    cmd = require("core.lazy_load").mason_cmds,
    module = "mason",
    after = "mason-lspconfig.nvim",
    config = function()
      require "plugins.configs.mason"
    end,
  },

  ["rafamadriz/friendly-snippets"] = {
    module = { "cmp", "cmp_nvim_lsp" },
    event = "InsertEnter",
  },

  ["L3MON4D3/LuaSnip"] = {
    config = function()
      require("plugins.configs.others").luasnip()
    end,
  },

  ["hrsh7th/nvim-cmp"] = {
    config = function()
      require "plugins.configs.cmp"
    end,
  },

  ["saadparwaiz1/cmp_luasnip"] = { after = "LuaSnip" },
  ["hrsh7th/cmp-nvim-lua"] = { after = "cmp_luasnip" },
  ["hrsh7th/cmp-nvim-lsp"] = { after = "cmp-nvim-lua" },
  ["hrsh7th/cmp-buffer"] = { after = "cmp-nvim-lsp" },
  ["hrsh7th/cmp-path"] = { after = "cmp-buffer" },

  ["sbdchd/neoformat"] = {},

  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "plugins.configs.nullls"
    end,
  },

  ["nvim-treesitter/nvim-treesitter"] = {
    -- commit = "4cccb6f",
    module = "nvim-treesitter",
    setup = function()
      require("core.lazy_load").on_file_open "nvim-treesitter"
    end,
    run = function()
      require("nvim-treesitter.install").update { with_sync = true }
    end,
    config = function()
      require "plugins.configs.treesitter"
    end,
  },

  -- git stuff
  ["lewis6991/gitsigns.nvim"] = {
    ft = "gitcommit",
    setup = function()
      require("core.lazy_load").gitsigns()
    end,
    config = function()
      require "plugins.configs.gitsigns"
    end,
  },
}

return plugins_code
