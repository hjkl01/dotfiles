local present, lspconfig = pcall(require, "lspconfig")

if not present then
	return
end

local M = {}
local utils = require "utils"

-- export on_attach & capabilities for custom lspconfigs

M.on_attach = function(client, bufnr)
	client.server_capabilities.documentFormattingProvider = true
	client.server_capabilities.documentRangeFormattingProvider = true

	utils.load_mappings("lspconfig", { buffer = bufnr })
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = false,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.lua_ls.setup {
	on_attach = M.on_attach,
	-- capabilities = M.capabilities,
	capabilities = capabilities,

	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand "$VIMRUNTIME/lua"] = true,
					[vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
					[vim.fn.stdpath "data" .. "/lazy/extensions/nvchad_types"] = true,
					[vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
		},
	},
}

local servers = { "pylsp", "ts_ls", "gopls", "lua_ls" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup { on_attach = M.on_attach, capabilities = capabilities }
end

local LspFormat = function()
	vim.lsp.buf.format { async = true }
end
vim.api.nvim_create_user_command("LspFormat", LspFormat, {})
-- vim.api.nvim_set_keymap("n", "<space>f", "<cmd> LspFormat w <CR>", { silent = true })

-- 自动保存文件
vim.api.nvim_command "autocmd BufWritePre * lua vim.lsp.buf.format()"
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   callback = function()
--     -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
--     -- vim.lsp.buf.formatting_sync()
--     vim.lsp.buf.format {}
--     -- vim.lsp.buf.format { async = false }
--   end,
-- })

return M
