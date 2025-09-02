local vim = vim
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
-- https://github.com/williamboman/mason-lspconfig.nvim
local servers = {
  "lua_ls",
  "ruff",
  "pylsp",
  -- "shfmt",
  -- "yamlls",
  -- "gopls",
  -- "ts_ls",
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
        download_url_template = "https://gh.hjkl01.cn/https://github.com/%s/releases/download/%s/%s",
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
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason.nvim",
    },

    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>fm",
        function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Global diagnostics configuration
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = true,
      })

      -- Executed for each LSP server
      local on_attach = function(client, bufnr)
        -- Enable formatting capabilities
        if client.supports_method("textDocument/formatting") then
          client.server_capabilities.documentFormattingProvider = true
          client.server_capabilities.documentRangeFormattingProvider = true
          -- Auto-format on save, buffer-local to this client
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true }),
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
            desc = "Format file on save",
          })
        end

        -- Standard LSP keymaps
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = bufnr, noremap = true, silent = true, desc = "LSP: " .. desc })
        end
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("gd", vim.lsp.buf.definition, "Goto Definition")
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")
        map("gi", vim.lsp.buf.implementation, "Goto Implementation")
        map("gr", vim.lsp.buf.references, "Goto References")
        map("gt", vim.lsp.buf.type_definition, "Goto Type Definition")
        -- map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        -- map("<leader>rn", vim.lsp.buf.rename, "Rename")
        map("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
        map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
      end

      -- Loop through servers and set them up
      for _, server_name in ipairs(servers) do
        local server_opts = {
          on_attach = on_attach,
          capabilities = capabilities,
        }

        -- Special settings for specific servers
        if server_name == "ruff" then
          server_opts.init_options = {
            settings = {
              lineLength = 120,
            },
          }
        end

        lspconfig[server_name].setup(server_opts)
      end
    end,
  },
}
