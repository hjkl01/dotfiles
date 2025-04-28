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

      local miniclue = require('mini.clue')
      miniclue.setup({
        triggers = {
          -- Leader triggers
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },

          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },

          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },
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
      })

      require("mini.cursorword").setup()

      require("mini.fuzzy").setup()
      -- nvim-telescope/telescope.nvim

      require('mini.icons').setup()

      -- Visualize and operate on indent scope
      require("mini.indentscope").setup()

      -- require("mini.map").setup()
      -- lua MiniMap.open()

      -- require("mini.notify").setup()

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
