return {
  {
    "mason-org/mason.nvim",
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
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.setup = opts.setup or {}

      -- opts.servers["*"] = opts.servers["*"] or {}
      opts.servers["*"].keys = vim.list_extend(opts.servers["*"].keys or {}, {
        {
          "gt",
          vim.lsp.buf.type_definition,
          desc = "Goto Type Definition",
        },
        {
          "<leader>fm",
          function()
            local ok, conform = pcall(require, "conform")
            if ok then
              conform.format({ async = false, lsp_fallback = true })
            else
              vim.lsp.buf.format({ async = false })
            end
            vim.cmd.write()
          end,
          desc = "Format and Save",
        },
      })

      opts.servers.ruff = vim.tbl_deep_extend("force", opts.servers.ruff or {}, {
        init_options = {
          settings = {
            lineLength = 180,
          },
        },
      })

      opts.servers.pylsp = vim.tbl_deep_extend("force", opts.servers.pylsp or {}, {
        settings = {
          pylsp = {
            plugins = {
              autopep8 = { enabled = false },
              mccabe = { enabled = false },
              pycodestyle = { enabled = false },
              pyflakes = { enabled = false },
              yapf = { enabled = false },
            },
          },
        },
      })

      local prev_setup_ruff = opts.setup.ruff
      opts.setup.ruff = function(server, server_opts)
        if prev_setup_ruff and prev_setup_ruff(server, server_opts) then
          return true
        end

        Snacks.util.lsp.on({ name = "ruff" }, function(_, client)
          client.server_capabilities.hoverProvider = false
        end)
      end
    end,
  },
}
