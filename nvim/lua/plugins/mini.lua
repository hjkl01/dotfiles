return {
  {
    "nvim-mini/mini.nvim",
    event = "VeryLazy",
    config = function()
      require("mini.comment").setup({
        mappings = {
          -- Toggle comment on current line
          comment_line = "//",
        },
      })

      local miniclue = require("mini.clue")
      miniclue.setup({
        triggers = {
          -- Leader triggers
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },

          -- Built-in completion
          { mode = "i", keys = "<C-x>" },

          -- `g` key
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },

          -- Marks
          { mode = "n", keys = "'" },
          { mode = "n", keys = "`" },
          { mode = "x", keys = "'" },
          { mode = "x", keys = "`" },

          -- Registers
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },

          -- Window commands
          { mode = "n", keys = "<C-w>" },

          -- `z` key
          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },
        },

        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },
        window = {
          -- Show window immediately
          delay = 0,

          config = {
            -- Compute window width automatically
            width = "auto",

            -- Use double-line border
            border = "double",
          },
        },
      })

      require("mini.cursorword").setup()
      require("mini.icons").setup()
      require("mini.indentscope").setup()
      require("mini.pairs").setup()
      require("mini.sessions").setup({
        directory = vim.fn.stdpath("data") .. "/sessions/",
      })
      -- require("mini.starter").setup()
      require("mini.trailspace").setup()
    end,
  },
}
