local M = {}

-- 缓存插件列表，避免每次启动都 glob 文件系统
local cache_file = vim.fn.stdpath("cache") .. "/dotfiles_plugins.json"
local config_dir = vim.fn.stdpath("config") .. "/lua/plugins"

local function get_plugin_modules()
  local plugin_modules = {}
  local files = vim.fn.glob(config_dir .. "/*.lua", false, false)
  if type(files) == "string" then
    files = vim.split(files, "\n")
  end
  for _, file in ipairs(files) do
    local name = vim.fn.fnamemodify(file, ":t:r")
    if name ~= "init" then
      table.insert(plugin_modules, "plugins." .. name)
    end
  end
  return plugin_modules
end

local function load_cached_modules()
  local ok, cached = pcall(function()
    local f = io.open(cache_file, "r")
    if not f then return nil end
    local content = f:read("*a")
    f:close()
    return vim.json.decode(content)
  end)
  if ok and cached and cached.modules then
    return cached.modules
  end
  return nil
end

local function save_cached_modules(modules)
  pcall(function()
    local f = io.open(cache_file, "w")
    if f then
      f:write(vim.json.encode({ modules = modules, timestamp = os.time() }))
      f:close()
    end
  end)
end

-- 检查缓存是否过期（插件目录有更新）
local function cache_valid()
  local ok, cached_stat = pcall(vim.uv.fs_stat, cache_file)
  if not ok or not cached_stat then return false end

  local dir_ok, dir_stat = pcall(vim.uv.fs_stat, config_dir)
  if not dir_ok or not dir_stat then return false end

  return cached_stat.mtime.sec > dir_stat.mtime.sec
end

local plugin_modules = nil
if cache_valid() then
  plugin_modules = load_cached_modules()
end

if not plugin_modules then
  plugin_modules = get_plugin_modules()
  save_cached_modules(plugin_modules)
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
