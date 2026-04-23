local M = {}

function M.setup()
  local conform = require("conform")

  conform.setup({
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff_format" },
      json = { "jq" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      sh = { "shfmt" },
    },
    format_on_save = {
      timeout_ms = 2000,
      lsp_format = "prefer",
    },
  })

  vim.keymap.set("n", "<leader>cf", function()
    conform.format({ async = false, lsp_format = "prefer" })
  end, { desc = "Format with Conform" })
end

return M
