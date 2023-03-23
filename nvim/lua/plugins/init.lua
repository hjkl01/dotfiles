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
  {
    "lukas-reineke/indent-blankline.nvim",
    init = function()
      require("core.utils").lazy_load "indent-blankline.nvim"
    end,
    opts = function()
      return require("plugins.configs.others").blankline
    end,
    config = function(_, opts)
      require("core.utils").load_mappings "blankline"
      require("indent_blankline").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    init = require("core.utils").lazy_load "nvim-treesitter",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "plugins.configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    ft = "gitcommit",
    init = function()
      -- load gitsigns only when a git file is opened
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
        callback = function()
          vim.fn.system("git -C " .. vim.fn.expand "%:p:h" .. " rev-parse")
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
            vim.schedule(function()
              require("lazy").load { plugins = { "gitsigns.nvim" } }
            end)
          end
        end,
      })
    end,
    opts = function()
      return require("plugins.configs.others").gitsigns
    end,
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },
  -- lsp stuff
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    opts = function()
      return require "plugins.configs.mason"
    end,
    config = function(_, opts)
      require("mason").setup(opts)

      -- custom cmd to install all mason binaries listed
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end, {})
    end,
  },
  -- { "williamboman/mason-lspconfig.nvim" },

  {
    "neovim/nvim-lspconfig",
    init = require("core.utils").lazy_load "nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },
  { "sbdchd/neoformat",      lazy = false },
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   lazy = false,
  --   after = "nvim-lspconfig",
  --   config = function()
  --     require "plugins.configs.nullls"
  --   end,
  -- },
  { "mfussenegger/nvim-lint" },
  -- load luasnips + cmp related in insert mode only
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        config = function()
          require("plugins.configs.others").luasnip()
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require "plugins.configs.cmp"
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
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
    keys = { "<leader>", '"', "'", "`" },
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
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
}

local config = require("core.utils").load_config()

-- lazy_nvim startup opts
local lazy_config = vim.tbl_deep_extend("force", require "plugins.configs.lazy_nvim", config.lazy_nvim)

require("lazy").setup(default_plugins, lazy_config)
