local vim = vim
return {
  {
    "github/copilot.vim",
    enabled = false, -- Disabled, uncomment to enable
    event = "BufEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      -- 接受 Copilot 的补全建议
      vim.keymap.set("i", "<C-g>", 'copilot#Accept("")', {
        expr = true,
        replace_keycodes = false,
        desc = "接受 Copilot 补全建议",
      })
    end,
  },
  {
    "Exafunction/windsurf.vim",
    enabled = false, -- Disabled, uncomment to enable
    config = function()
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-;>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-,>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true })
    end,
  },
}
