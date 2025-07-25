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
        download_url_template = "https://github.com/%s/releases/download/%s/%s",
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
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Define the on_attach function to apply settings to each LSP client
      local on_attach = function(client, bufnr)
        -- Enable formatting capabilities
        client.server_capabilities.documentFormattingProvider = true
        client.server_capabilities.documentRangeFormattingProvider = true

        -- You can add keymaps or other buffer-local settings here
        -- e.g., vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
      end

      -- Configure diagnostics
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = true,
      })

      -- Loop through the servers and set them up
      for _, server_name in ipairs(servers) do
        lspconfig[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end

      -- Specific setup for ruff, if needed
      lspconfig.ruff.setup({
        init_options = {
          settings = {
            lineLength = 120,
          },
        },
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- Auto-format on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function()
          vim.lsp.buf.format({ async = true })
        end,
        desc = "Format file on save",
      })
    end,
  },
}
