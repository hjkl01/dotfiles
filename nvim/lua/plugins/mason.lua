return {
  {
    "williamboman/mason.nvim",
    -- dependencies = { "williamboman/mason-lspconfig.nvim" },
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    build = "MasonInstallAll",
    opts = {
      -- install_root_dir = path.concat { vim.fn.stdpath "data", "mason" },
      PATH = "skip",
      -- PATH = "append",
      -- PATH = "prepend",
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
      }, -- not an option from mason.nvim
    },

    config = function(_, opts)
      require("mason").setup(opts)
      -- require("mason-lspconfig").setup()

      -- custom cmd to install all mason binaries listed
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end, {})

      -- -- add binaries installed by mason.nvim to path
      -- local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
      -- vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. vim.fn.stdpath "data" .. "/mason/bin"
    end,
  }
}
