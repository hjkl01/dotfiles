return {
  {
    "github/copilot.vim",
    enabled = false, -- Disabled, uncomment to enable
    event = "BufEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.keymap.set("i", "<C-g>", 'copilot#Accept("<CR>")', { silent = true, expr = true, script = true })
    end,
  },
  -- {
  --   "Exafunction/codeium.vim",
  --   enabled = false, -- Disabled, uncomment to enable
  --   event = "BufEnter",
  --   config = function()
  --     -- Change '<C-g>' here to any keycode you like.
  --     vim.keymap.set("i", "<C-g>", function()
  --       return vim.fn["codeium#Accept"]()
  --     end, { expr = true, silent = true })
  --     vim.keymap.set("i", "<c-;>", function()
  --       return vim.fn["codeium#CycleCompletions"](1)
  --     end, { expr = true, silent = true })
  --     vim.keymap.set("i", "<c-,>", function()
  --       return vim.fn["codeium#CycleCompletions"](-1)
  --     end, { expr = true, silent = true })
  --     vim.keymap.set("i", "<c-x>", function()
  --       return vim.fn["codeium#Clear"]()
  --     end, { expr = true, silent = true })
  --   end,
  -- }

}
