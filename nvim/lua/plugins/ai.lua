local M = {}

function M.setup()
  vim.g.copilot_no_tab_map = true
  if vim.env.NVIM_ENABLE_COPILOT == "1" then
    require("config.pack").load("copilot.vim")
  else
    vim.g.loaded_copilot = 1
  end

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
