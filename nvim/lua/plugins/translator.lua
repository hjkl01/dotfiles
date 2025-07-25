return {
  {
    "voldikss/vim-translator",
    cmd = "Translate",
    keys = {
      { "tt", "<cmd>TranslateW<CR>", mode = { "n", "v" }, desc = "Translate Window" },
    },
    init = function()
      vim.g.translator_default_engines = { "haici", "bing" }
    end,
  },
}
