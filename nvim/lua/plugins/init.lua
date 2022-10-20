local plugins = {

  ["nvim-lua/plenary.nvim"] = { module = "plenary" },

  ["lewis6991/impatient.nvim"] = {
    config = function()
      require "impatient"
    end,
  },

  ["wbthomason/packer.nvim"] = {
    cmd = require("core.lazy_load").packer_cmds,
    config = function()
      require "plugins"
    end,
  },

  ["lukas-reineke/indent-blankline.nvim"] = {
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "indent-blankline.nvim"
      require("core.utils").load_mappings "blankline"
    end,
    config = function()
      require("plugins.configs.others").blankline()
    end,
  },

  ["nvim-treesitter/nvim-treesitter"] = {
    module = "nvim-treesitter",
    setup = function()
      require("core.lazy_load").on_file_open "nvim-treesitter"
    end,
    cmd = require("core.lazy_load").treesitter_cmds,
    run = ":TSUpdate",
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
      require("plugins.configs.others").gitsigns()
    end,
  },

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

  -- misc plugins
  ["windwp/nvim-autopairs"] = {
    config = function()
      require("plugins.configs.others").autopairs()
    end,
  },

  ["numToStr/Comment.nvim"] = {
    module = "Comment",
    keys = { "gc", "gb" },
    config = function()
      require("plugins.configs.others").comment()
    end,
    setup = function()
      require("core.utils").load_mappings "comment"
    end,
  },

  -- file managing , picker etc

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

  ["nvim-telescope/telescope.nvim"] = {
    cmd = "Telescope",
    config = function()
      require "plugins.configs.telescope"
    end,
    setup = function()
      require("core.utils").load_mappings "telescope"
    end,
  },

  ["voldikss/vim-translator"] = {
    config = function()
      vim.g.translator_default_engines = { "haici", "youdao", "bing" }
    end,
  },

  ["monsonjeremy/onedark.nvim"] = {
    config = function()
      require("plugins.configs.others").onedark()
    end,
  },

  ["feline-nvim/feline.nvim"] = {
    config = function()
      -- require('feline').setup()
      require 'plugins.configs.feline'
    end,
  },

  ["sbdchd/neoformat"] = {},

  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "plugins.configs.nullls"
    end,
  },

  ["iamcco/markdown-preview.nvim"] = {
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
}

-- Load all plugins
local present, packer = pcall(require, "packer")

if present then
  vim.cmd "packadd packer.nvim"

  -- Override with default plugins with user ones
  plugins = require("core.utils").merge_plugins(plugins)

  -- load packer init options
  local init_options = require("plugins.configs.others").packer_init()
  init_options = require("core.utils").load_override(init_options, "wbthomason/packer.nvim")
  packer.init(init_options)

  for _, v in pairs(plugins) do
    packer.use(v)
  end
end
