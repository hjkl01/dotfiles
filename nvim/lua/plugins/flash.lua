local M = {}

function M.setup()
  local ok, flash = pcall(require, "flash")
  if not ok then
    return
  end

  flash.setup({})

  vim.keymap.set({ "n", "x", "o" }, "?", function()
    flash.jump()
  end, { desc = "Flash" })
end

return M
