return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = true
        client.server_capabilities.documentRangeFormattingProvider = true
      end
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require('lspconfig')

      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
      local servers = { "pylsp", "ts_ls", "gopls", "lua_ls", "bashls" }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup { on_attach = on_attach, capabilities = capabilities }
      end

      local LspFormat = function()
        vim.lsp.buf.format { async = true }
      end
      vim.api.nvim_create_user_command("LspFormat", LspFormat, {})
      -- vim.api.nvim_set_keymap("n", "<space>f", "<cmd> LspFormat w <CR>", { silent = true })

      vim.api.nvim_command "autocmd BufWritePre * lua vim.lsp.buf.format()"
    end
  }
}
