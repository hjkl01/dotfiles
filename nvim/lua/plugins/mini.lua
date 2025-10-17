return {
  {
    "nvim-mini/mini.nvim",
    -- event = "VeryLazy",
    config = function()
      require("mini.pairs").setup()
    end,
  },
}
