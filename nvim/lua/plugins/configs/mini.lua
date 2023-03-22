local line_ok, comment = pcall(require, "mini.comment")
if not line_ok then
  return
end

-- mini.comment.setup(
local options = {
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

comment.setup(options)

local _, cursorword = pcall(require, "mini.cursorword")
cursorword.setup()

-- local _,fuzzy = pcall(require, "mini.fuzzy")
-- fuzzy.setup()
-- nvim-telescope/telescope.nvim

-- Visualize and operate on indent scope
local _, indentscope = pcall(require, "mini.indentscope")
indentscope.setup()

-- local _, map = pcall(require, "mini.map")
-- map.setup()
-- lua MiniMap.open()

-- ["windwp/nvim-autopairs"] = {
--   config = function()
--     require("plugins.configs.others").autopairs()
--   end,
-- },
local _, minipairs = pcall(require, "mini.pairs")
minipairs.setup()

local _, sessions = pcall(require, "mini.sessions")
sessions.setup {
  directory = "~/.local/share/nvim/",
}

local _, starter = pcall(require, "mini.starter")
starter.setup()

-- local _,statusline = pcall(require, "mini.statusline")
-- statusline.setup()

-- local _,surround = pcall(require, "mini.surround")
-- surround.setup()

-- trailing whitespace
local _, trailspace = pcall(require, "mini.trailspace")
trailspace.setup()
