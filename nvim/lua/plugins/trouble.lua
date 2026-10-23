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
end

return M