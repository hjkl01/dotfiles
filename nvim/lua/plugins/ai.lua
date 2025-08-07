return {
  {
    "github/copilot.vim",
    -- enabled = false, -- Disabled, uncomment to enable
    event = "BufEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      -- 接受 Copilot 的补全建议
      vim.keymap.set("i", "<C-j>", 'copilot#Accept("")', {
        expr = true,
        replace_keycodes = false,
        desc = "接受 Copilot 补全建议",
      })

      -- 触发 Copilot 补全（默认可能自动触发，此为手动触发快捷键）
      vim.keymap.set("i", "<C-l>", "<Plug>(copilot-next)", {
        desc = "触发 Copilot 补全",
      })

      -- 查看上一个补全建议
      vim.keymap.set("i", "<C-k>", "<Plug>(copilot-previous)", {
        desc = "查看上一个 Copilot 补全建议",
      })

      -- 取消 Copilot 补全
      vim.keymap.set("i", "<C-]>", "<Plug>(copilot-dismiss)", {
        desc = "取消 Copilot 补全建议",
      })
    end,
  },
  {
    "Exafunction/codeium.vim",
    enabled = false, -- Disabled, uncomment to enable
    event = "BufEnter",
    config = function()
      -- Change '<C-g>' here to any keycode you like.
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
