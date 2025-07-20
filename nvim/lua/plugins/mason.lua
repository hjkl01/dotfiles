-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
-- https://github.com/williamboman/mason-lspconfig.nvim
local servers = {
  -- "bashls",
  -- 'cmake',
  -- 'clangd',
  -- "gopls",
  -- 'jsonls',
  "lua_ls",
  "ruff",
  "pylsp",
  -- "sqlls",
  -- "taplo",
  -- "ts_ls",
  -- "yamlls",
}

return {
  {
    "williamboman/mason.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    opts = {
      PATH = "prepend",
      max_concurrent_installers = 10,
      github = {
        ---@since 1.0.0
        -- The template URL to use when downloading assets from GitHub.
        -- The placeholders are the following (in order):
        -- 1. The repository (e.g. "rust-lang/rust-analyzer")
        -- 2. The release version (e.g. "v0.3.0")
        -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
        -- download_url_template = "https://github.com/%s/releases/download/%s/%s",
        download_url_template = vim.fn.getenv("GITHUB_MIRROR") .. "/https://github.com/%s/releases/download/%s/%s",
        -- download_url_template = "https://ghproxy.cxkpro.top/https://github.com/%s/releases/download/%s/%s",
      },
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },

    config = function(_, opts)
      require("mason").setup(opts)

      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_installation = true,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = true
        client.server_capabilities.documentRangeFormattingProvider = true
      end
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require('lspconfig')

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = true,
      })

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup { on_attach = on_attach, capabilities = capabilities }
      end

      require('lspconfig').ruff.setup {
        init_options = {
          settings = {
            lineLength = 120
          }
        }
      }

      local LspFormat = function()
        vim.lsp.buf.format { async = true }
      end
      vim.api.nvim_create_user_command("LspFormat", LspFormat, {})
      -- vim.api.nvim_set_keymap("n", "<space>f", "<cmd> LspFormat w <CR>", { silent = true })

      vim.api.nvim_command "autocmd BufWritePre * lua vim.lsp.buf.format()"
    end
  }
}
