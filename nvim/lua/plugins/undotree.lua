local M = {}

function M.setup()
  vim.keymap.set("n", "<leader>ud", "<cmd>UndotreeToggle<CR>", { desc = "Undo tree" })
end

return M
