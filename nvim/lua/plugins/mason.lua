return {
  {
    "williamboman/mason.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    build = "MasonInstallAll",
    opts = {
      -- install_root_dir = path.concat { vim.fn.stdpath "data", "mason" },
      -- PATH = "skip",
      -- PATH = "append",
      PATH = "prepend",
      max_concurrent_installers = 10,
      github = {
        download_url_template = "https://gh.hjkl01.cn/proxy/https://github.com/%s/releases/download/%s/%s",
      },
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "ruff",
        "prettier",
        "fixjson",
        "yamlfmt",
        "shfmt",
        "python-lsp-server",
        "bash-language-server",
        "typescript-language-server",
        "gopls",
        "sqlfluff",
      },
    },

    config = function(_, opts)
      require("mason").setup(opts)

      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",
          "gopls",
          -- 'jsonls',
          "lua_ls",
          "ruff",
          "pylsp",
          -- "sqlls",
          "ts_ls",
          -- "yamlls",
        },
        automatic_installation = true,
      })

      -- custom cmd to install all mason binaries listed
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end, {})
    end,
  }
}
