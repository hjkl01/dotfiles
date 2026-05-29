local M = {}

function M.setup()
  local ok, which_key = pcall(require, "which-key")
  if not ok then
    return
  end
  which_key.setup({})

  which_key.add({
    { "<leader>/", desc = "Toggle comment line" },
    { "<leader>?", desc = "Toggle comment operator" },
    { "<leader>u", desc = "Update vim.pack plugins" },
    { "ff",        desc = "Format code" },
    { " r",        desc = "Run file" },
  })
end

return M
