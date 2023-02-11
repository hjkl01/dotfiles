local present, mason_lspconfig = pcall(require, "mason-lspconfig")

if not present then
  return
end
mason_lspconfig.setup()

local mason_present, mason = pcall(require, "mason")

if not mason_present then
  return
end

local options = {
  ensure_installed = {
    "python-lsp-server",
    "lua-language-server",
    -- "stylua",
    -- "typescript-language-server",
    "bash-language-server",
    "prettier",
  }, -- not an option from mason.nvim

  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ﮊ",
    },

    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },

  max_concurrent_installers = 10,
}

vim.api.nvim_create_user_command("MasonInstallAll", function()
  vim.cmd("MasonInstall " .. table.concat(options.ensure_installed, " "))
end, {})

options = require("core.utils").load_override(options, "williamboman/mason.nvim")

mason.setup(options)
