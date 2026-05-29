local M = {}

function M.setup()
  local ok, diffview = pcall(require, "diffview")
  if not ok then
    return
  end

  diffview.setup({})

  vim.keymap.set("n", "<leader>dv", "<cmd>DiffviewOpen<CR>", { desc = "Diffview open" })
  vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<CR>", { desc = "Diffview close" })
  vim.keymap.set("n", "<leader>dh", "<cmd>DiffviewFileHistory<CR>", { desc = "Diffview file history" })
end

return M
