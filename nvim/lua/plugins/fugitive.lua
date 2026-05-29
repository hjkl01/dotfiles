local M = {}

function M.setup()
  vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Git status" })
  vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<CR>", { desc = "Git commit" })
  vim.keymap.set("n", "<leader>gp", "<cmd>Git push<CR>", { desc = "Git push" })
  vim.keymap.set("n", "<leader>gl", "<cmd>Git log<CR>", { desc = "Git log" })
  vim.keymap.set("n", "<leader>gd", "<cmd>Git diff<CR>", { desc = "Git diff" })
end

return M
