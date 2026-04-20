local M = {}

function M.setup()
  vim.g.copilot_no_tab_map = true

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
end

return M
