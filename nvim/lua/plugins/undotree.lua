local M = {}

function M.setup()
  vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "Undotree toggle" })
end

return M

