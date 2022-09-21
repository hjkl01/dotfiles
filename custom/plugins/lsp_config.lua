local present, lspconfig = pcall(require, "lspconfig")

if not present then
	return
end

local M = {}

local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local servers = { "pylsp" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({ on_attach = on_attach, capabilities = capabilities })
end

return M
