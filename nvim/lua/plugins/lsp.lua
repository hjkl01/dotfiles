return {
  "neovim/nvim-lspconfig",
  lazy = false,
  -- dependencies = {
  --   "mason.nvim",
  --   { "williamboman/mason-lspconfig.nvim", config = function() end },
  -- },
  config = function()
    local on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = true
      client.server_capabilities.documentRangeFormattingProvider = true
    end
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local lspconfig = require('lspconfig')

    local servers = { "pylsp", "ts_ls", "gopls", "lua_ls" }
    for _, lsp in ipairs(servers) do
      -- print(lsp)
      lspconfig[lsp].setup { on_attach = on_attach, capabilities = capabilities }
      -- print(lsp, 'start success')
    end

    local LspFormat = function()
      vim.lsp.buf.format { async = true }
    end
    vim.api.nvim_create_user_command("LspFormat", LspFormat, {})
    -- vim.api.nvim_set_keymap("n", "<space>f", "<cmd> LspFormat w <CR>", { silent = true })

    -- 自动保存文件
    vim.api.nvim_command "autocmd BufWritePre * lua vim.lsp.buf.format()"
  end
}
