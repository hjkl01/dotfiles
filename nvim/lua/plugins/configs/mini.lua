-- require("mini.animate").setup()

-- require("mini.basics").setup()

require("mini.comment").setup {
  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Toggle comment (like `gcip` - comment inner paragraph) for both
    -- Normal and Visual modes
    comment = "gc",
    -- Toggle comment on current line
    -- comment_line = "<C-/>",
    comment_line = "//",
    -- Define 'comment' textobject (like `dgc` - delete whole comment block)
    textobject = "gc",
  },
  -- Hook functions to be executed at certain stage of commenting
  hooks = {
    -- Before successful commenting. Does nothing by default.
    pre = function()
    end,
    -- After successful commenting. Does nothing by default.
    post = function()
    end,
  },
}

require("mini.cursorword").setup()

-- require("mini.fuzzy").setup()
-- nvim-telescope/telescope.nvim

-- Visualize and operate on indent scope
require("mini.indentscope").setup()

-- require("mini.map").setup()
-- lua MiniMap.open()

require("mini.pairs").setup()
require("mini.sessions").setup {
  directory = "~/.local/share/nvim/",
}
require("mini.starter").setup()
-- require("mini.statusline").setup()
require("mini.surround").setup()

-- trailing whitespace
require("mini.trailspace").setup()
