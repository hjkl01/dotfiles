local M = {}

M.setup_lsp = function(attach, capabilities)
   local lspconfig = require "lspconfig"

   local servers = { "bashls", "pylsp" }

   for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
         on_attach = attach,
         capabilities = capabilities,
         root_dir = vim.loop.cwd,
      }
   end

   -- temporarily disable tsserver suggestions
   require("lspconfig").tsserver.setup {
      init_options = {
         preferences = {
            disableSuggestions = true,
         },
      },

      on_attach = function(client, bufnr)
         client.resolved_capabilities.document_formatting = true
         vim.api.nvim_buf_set_keymap(bufnr, "n", "ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
      end,
   }
end

return M
