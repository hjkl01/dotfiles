local M = {}

function M.setup()
  local conform = require("conform")

  conform.setup({
    formatters_by_ft = {
      lua = { "stylua" },
      python = { { "ruff_format", extra_args = { "--line-length", "160" } } },
      json = { "jq" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      sh = { "shfmt" },
    },
  })

  vim.keymap.set("n", "<leader>cf", function()
    conform.format({ async = true })
  end, { desc = "Format" })
end

return M
