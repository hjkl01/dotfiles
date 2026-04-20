local M = {}

function M.setup()
  vim.keymap.set("n", "<TAB>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
  vim.keymap.set("n", "<S-TAB>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })

  require("bufferline").setup({
    options = {
      -- diagnostics = "nvim_lsp",
      -- always_show_bufferline = true,
    },
  })
end

return M
