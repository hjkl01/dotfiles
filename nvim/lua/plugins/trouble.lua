local M = {}

function M.setup()
  require("trouble").setup({})

  vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
  vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix (Trouble)" })


  local last_line = -1

  vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
      local line = vim.api.nvim_win_get_cursor(0)[1]
      if line == last_line then return end
      last_line = line

      local diagnostics = vim.diagnostic.get(0, { lnum = line - 1 })

      for _, d in ipairs(diagnostics) do
        if d.severity == vim.diagnostic.severity.WARN then
          vim.diagnostic.open_float(nil, {
            focus = false,
            scope = "cursor",
          })
          return
        end
      end
    end,
  })
end

return M
