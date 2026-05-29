local M = {}

function M.setup()
  local ok, lazydev = pcall(require, "lazydev")
  if not ok then
    return
  end
  lazydev.setup({
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  })
end

return M
