local code_plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    init = require("utils").lazy_load "nvim-treesitter",
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
    init = require("utils").lazy_load "nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },

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

  -- {
  --   "stevearc/conform.nvim",
  --   lazy = false,
  --   config = function()
  --     require("conform").setup {
  --       formatters_by_ft = {
  --         -- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
  --         lua = { "stylua" },
  --         -- Conform will run multiple formatters sequentially
  --         -- python = { "black" },
  --         -- Use a sub-list to run only the first available formatter
  --         javascript = { { "prettier", "prettierd" } },
  --         go = { "gofmt" },
  --         -- Use the "*" filetype to run formatters on all filetypes.
  --         ["*"] = { "codespell" },
  --         -- Use the "_" filetype to run formatters on filetypes that don't
  --         -- have other formatters configured.
  --         ["_"] = { "trim_whitespace" },
  --       },
  --       format_on_save = {
  --         -- I recommend these options. See :help conform.format for details.
  --         lsp_fallback = true,
  --         timeout_ms = 500,
  --       },
  --     }
  --   end,
  -- },

  -- Database UI
  -- {
  --   "kristijanhusak/vim-dadbod-ui",
  --   dependencies = {
  --     { "tpope/vim-dadbod",                     lazy = true },
  --     { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  --   },
  --   cmd = {
  --     "DBUI",
  --     "DBUIToggle",
  --     "DBUIAddConnection",
  --     "DBUIFindBuffer",
  --   },
  --   init = function()
  --     -- Your DBUI configuration
  --     vim.g.db_ui_use_nerd_fonts = 1
  --   end,
  -- },
}

return code_plugins
