local M = {}

function M.setup()
  require("snacks").setup({
    notifier = { enabled = true },
    quickfile = { enabled = true },
  })
end

return M
