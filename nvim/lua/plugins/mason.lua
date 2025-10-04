-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
-- https://github.com/williamboman/mason-lspconfig.nvim

local vim = vim
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
      "williamboman/mason.nvim",
    },

    keys = {
      {
        "<leader>fm",
        function()
          vim.lsp.buf.format({
            bufnr = vim.api.nvim_get_current_buf(),
            async = false,
          })
          vim.cmd("write")
        end,
        desc = "LSP Format and Save",
      },
      {
        "K",
        vim.lsp.buf.hover,
        desc = "LSP: Hover Documentation",
      },
      {
        "gd",
        vim.lsp.buf.definition,
        desc = "LSP: Goto Definition",
      },
      {
        "gD",
        vim.lsp.buf.declaration,
        desc = "LSP: Goto Declaration",
      },
      {
        "gi",
        vim.lsp.buf.implementation,
        desc = "LSP: Goto Implementation",
      },
      {
        "gr",
        vim.lsp.buf.references,
        desc = "LSP: Goto References",
      },
      {
        "gt",
        vim.lsp.buf.type_definition,
        desc = "LSP: Goto Type Definition",
      },
      {
        "[d",
        vim.diagnostic.goto_prev,
        desc = "LSP: Previous Diagnostic",
      },
      {
        "]d",
        vim.diagnostic.goto_next,
        desc = "LSP: Next Diagnostic",
      },
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()

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
          -- vim.api.nvim_create_autocmd("BufWritePre", {
          --   group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true }),
          --   buffer = bufnr,
          --   callback = function()
          --     vim.lsp.buf.format({ bufnr = bufnr })
          --   end,
          --   desc = "Format file on save",
          -- })
        end

        -- Standard LSP keymaps (now defined in keys section above)
      end

      -- Loop through servers and set them up
      for _, server_name in ipairs(servers) do
        local server_opts = {
          on_attach = on_attach,
          capabilities = capabilities,
        }

        -- Special settings for specific servers

        if server_name == "pylsp" then
          server_opts.init_options = {
            pylsp = {
              plugins = {
                pycodestyle = {
                  ignore = { "E501" },
                  -- 或者用 select 只启用你想看的错误
                  -- select = { "E", "W" }, -- 不推荐，会覆盖 ignore
                },
                -- 如果你用的是 flake8 插件：
                flake8 = {
                  ignore = { "E501" },
                },
              },
            },
          }
        end

        if server_name == "ruff" then
          server_opts.init_options = {
            settings = {
              lineLength = 120,
            },
          }
        end

        vim.lsp.config[server_name] = server_opts
      end

      for _, server_name in ipairs(servers) do
        vim.lsp.enable(server_name)
      end
    end,
  },
}
