return {
  "williamboman/mason.nvim",
  dependencies = { "williamboman/mason-lspconfig.nvim" },
  cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
  opts = {
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
      -- "stylua",
      "ruff",
      "prettier",
      "fixjson",
      -- "yamlfmt",
      -- "shfmt",
      "python-lsp-server",
      -- "bash-language-server",
      "typescript-language-server",
      "gopls",
    }, -- not an option from mason.nvim
    PATH = "skip",
    max_concurrent_installers = 10,
  },

  config = function(_, opts)
    require("mason").setup(opts)
    require("mason-lspconfig").setup()

    -- custom cmd to install all mason binaries listed
    vim.api.nvim_create_user_command("MasonInstallAll", function()
      vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
    end, {})
  end,
}
