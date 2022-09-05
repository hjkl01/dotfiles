-- custom.plugins.lspconfig
-- local on_attach = require("plugins.configs.lspconfig").on_attach
-- local capabilities = require("plugins.configs.lspconfig").capabilities

-- local lspconfig_c = require "lspconfig"

-- local servers = { 'pylsp', 'sumneko_lua' }
-- for _, lsp in ipairs(servers) do
--   -- lspconfig_c[lsp].setup {
--   require('lspconfig')[lsp].setup {
--     -- on_attach = on_attach,
--     -- capabilities = capabilities,
--   }
-- end

local present, lspconfig = pcall(require, "lspconfig")

if not present then
  return
end

local M = {}

local config = require('plugins.configs.lspconfig')

lspconfig.pylsp.setup {
  on_attach = config.on_attach,
  capabilities = config.capabilities,
}


return M
