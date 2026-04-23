local M = {}
local did_setup = false

local function ensure_loaded()
  if did_setup then
    return true
  end

  if not require("config.pack").load("persistence.nvim") then
    return false
  end

  require("persistence").setup({})
  did_setup = true
  return true
end

function M.setup()
  vim.keymap.set("n", "<leader>qs", function()
    if ensure_loaded() then
      require("persistence").load()
    end
  end, { desc = "Restore Session" })

  vim.api.nvim_create_autocmd("VimEnter", {
    callback = ensure_loaded,
  })
end

return M
