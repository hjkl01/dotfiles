local M = {}

function M.setup()
  vim.g.copilot_no_tab_map = true
  if vim.env.NVIM_ENABLE_COPILOT == "1" then
    require("config.pack").load("copilot.vim")
  else
    vim.g.loaded_copilot = 1
  end
end

return M
