local M = {}

function M.setup()
  require("lualine").setup({
    options = {
      theme = "auto",
      globalstatus = true,
    },
  })
end

return M
