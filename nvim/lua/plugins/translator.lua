local M = {}
local did_load = false

local function ensure_loaded()
  if not did_load then
    if not require("config.pack").load("vim-translator") then
      return false
    end
    did_load = true
  end

  return true
end

local function translate_window()
  if not ensure_loaded() then
    return
  end

  vim.cmd("TranslateW")
end

local function translate_selection()
  if not ensure_loaded() then
    return
  end

  vim.cmd("'<,'>TranslateW")
end

function M.setup()
  vim.g.translator_default_engines = { "haici", "bing" }
  vim.keymap.set("n", "tt", translate_window, { desc = "Translate Window" })
  vim.keymap.set("v", "tt", translate_selection, { desc = "Translate Selection" })
end

return M
