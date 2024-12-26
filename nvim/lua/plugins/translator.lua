return {
  {
    "voldikss/vim-translator",
    cmd = "Translate",
    lazy = false,
    config = function()
      vim.g.translator_default_engines = { "haici", "bing" }
    end,
  },
}
