local M = {}
local did_setup = false

local function ensure_loaded()
  if did_setup then
    return true
  end

  if not require("config.pack").load("trouble.nvim") then
    return false
  end

  require("trouble").setup({})
  did_setup = true
  return true
end

function M.setup()
  local last_line = -1

  vim.keymap.set("n", "<leader>xx", function()
    if ensure_loaded() then
      vim.cmd("Trouble diagnostics toggle")
    end
  end, { desc = "Diagnostics (Trouble)" })

  vim.keymap.set("n", "<leader>xq", function()
    if ensure_loaded() then
      vim.cmd("Trouble qflist toggle")
    end
  end, { desc = "Quickfix (Trouble)" })

  vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
      local line = vim.api.nvim_win_get_cursor(0)[1]
      if line == last_line then
        return
      end
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
