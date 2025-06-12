return {
  {
    "voldikss/vim-translator",
    cmd = "Translate",
    lazy = false,
    config = function()
      vim.g.translator_default_engines = { "haici", "bing" }

      vim.keymap.set({ 'n', 'v' }, 'tt', "<cmd> TranslateW <CR>", { desc = "translate window", remap = true })
    end,
  },
}
