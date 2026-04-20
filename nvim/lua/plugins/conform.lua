local M = {}

function M.setup()
  require("conform").setup({
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
      lsp_fallback = true,
    },
  })
end

return M
