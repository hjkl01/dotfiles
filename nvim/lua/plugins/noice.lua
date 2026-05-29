local M = {}

function M.setup()
  local ok, noice = pcall(require, "noice")
  if not ok then
    return
  end
  noice.setup({})
end

return M
