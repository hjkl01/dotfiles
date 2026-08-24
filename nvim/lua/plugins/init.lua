local M = {}

local plugin_modules = {}
local config_dir = vim.fn.stdpath('config') .. '/lua/plugins'
local files = vim.fn.glob(config_dir .. '/*.lua', false, false)
if type(files) == "string" then
  files = vim.split(files, "\n")
end
for _, file in ipairs(files) do
  local name = vim.fn.fnamemodify(file, ":t:r")
  if name ~= "init" then
    table.insert(plugin_modules, "plugins." .. name)
  end
end

function M.setup()
  for _, mod in ipairs(plugin_modules) do
    local ok, plugin = pcall(require, mod)
    if ok and type(plugin) == "table" and type(plugin.setup) == "function" then
      local setup_ok, err = pcall(plugin.setup)
      if not setup_ok then
        vim.notify(string.format("Plugin setup failed: %s\n%s", mod, err), vim.log.levels.ERROR)
      end
    elseif not ok then
      vim.notify(string.format("Plugin module load failed: %s\n%s", mod, plugin), vim.log.levels.ERROR)
    end
  end
end

return M
