local M = {}

function M.setup()
  local ok, which_key = pcall(require, "which-key")
  if not ok then
    return
  end
  which_key.setup({})

  which_key.add({
    { "<leader>u", group = "update" },
  })
end

return M
