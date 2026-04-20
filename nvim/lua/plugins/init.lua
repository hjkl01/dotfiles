local M = {}

local plugin_modules = {
  "plugins.colorscheme",
  "plugins.flash",
  "plugins.blink",
  "plugins.conform",
  "plugins.treesitter",
  "plugins.lint",
  "plugins.noice",
  "plugins.which-key",
  "plugins.trouble",
  "plugins.todo-comments",
  "plugins.fzflua",
  "plugins.snacks",
  "plugins.persistence",
  "plugins.lazydev",
  "plugins.lualine",
  "plugins.mason",
  "plugins.mini",
  "plugins.neo-tree",
  "plugins.ai",
  "plugins.gitsigns",
  "plugins.bufferline",
  "plugins.translator",
}

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
