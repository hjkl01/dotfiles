local M = {}

function M.setup()
  require("fzf-lua").setup({
    fzf_colors = true,
    winopts = {
      preview = {
        default = "bat",
      },
    },
  })

  vim.keymap.set("n", "<leader><leader>", "<cmd>FzfLua files<cr>", { desc = "Find Files" })
  vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", { desc = "Live Grep" })
  vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Buffers" })
  vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua helptags<cr>", { desc = "Help Tags" })

  vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions jump1=true ignore_current_line=true<cr>",
    { desc = "Goto Definition" })
  vim.keymap.set("n", "gr", "<cmd>FzfLua lsp_references jump1=true ignore_current_line=true<cr>",
    { desc = "Goto References" })
  vim.keymap.set("n", "gI", "<cmd>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>",
    { desc = "Goto Implementations" })
  vim.keymap.set("n", "gy", "<cmd>FzfLua lsp_typedefs jump1=true ignore_current_line=true<cr>",
    { desc = "Goto Type Definition" })
end

return M
