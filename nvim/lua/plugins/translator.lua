local M = {}

function M.setup()
  vim.g.translator_default_engines = { "haici", "bing" }
  vim.keymap.set({ "n", "v" }, "tt", "<cmd>TranslateW<CR>", { desc = "Translate Window" })
end

return M
