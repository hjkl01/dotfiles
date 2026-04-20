local M = {}

function M.setup()
  require("persistence").setup({})

  vim.keymap.set("n", "<leader>qs", function()
    require("persistence").load()
  end, { desc = "Restore Session" })
end

return M
