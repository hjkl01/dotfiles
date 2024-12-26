return {

  {
    "echasnovski/mini.nvim",
    lazy = false,
    config = function()
      require("mini.animate").setup()

      require("mini.comment").setup {
        mappings = {
          -- Toggle comment on current line
          comment_line = "//",
        },
      }

      -- require("mini.colors").setup()

      -- require("mini.completion").setup()

      require("mini.cursorword").setup()

      require("mini.fuzzy").setup()
      -- nvim-telescope/telescope.nvim

      require('mini.icons').setup()

      -- Visualize and operate on indent scope
      require("mini.indentscope").setup()

      -- require("mini.map").setup()
      -- lua MiniMap.open()

      require("mini.notify").setup()

      require("mini.pairs").setup()
      require("mini.sessions").setup {
        directory = "~/.local/share/nvim/",
      }
      require("mini.starter").setup()

      -- require("mini.statusline").setup()

      -- require("mini.surround").setup()

      -- require("mini.tabline").setup()

      -- trailing whitespace
      require("mini.trailspace").setup()
    end,
  },
}
