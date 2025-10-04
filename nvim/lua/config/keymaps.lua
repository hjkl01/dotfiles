-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("i", "<C-b>", "<ESC>^i", { desc = "beginning of line", remap = true })
map("i", "<C-e>", "<End>", { desc = "end of line", remap = true })

-- 开始定义快捷键映射
map("n", "<ESC>", ":noh<CR>", { desc = "no highlight" })
map({ "n", "v" }, "H", "0", { desc = "Home" })
map({ "n", "v" }, "L", "$", { desc = "End" })
map("n", "q", "<cmd>q<CR>", { desc = "﬚  quit file" })
map("n", "W", "<cmd>w<CR>", { desc = "﬚  save file" })
map("n", "#", "*<CR>", { desc = "next ident" })

map("n", "ff", function()
  local formatters = {
    python = function()
      vim.cmd([[r !black -l 120 -q %]])
    end,
    json = function()
      vim.cmd(
        [[%!python3 -c 'import json, sys, collections; print(json.dumps(json.load(sys.stdin, object_pairs_hook=collections.OrderedDict), ensure_ascii=False, indent=4))']]
      )
    end,
    -- Add other filetype formatters here
  }

  local filetype = vim.bo.filetype
  local formatter = formatters[filetype]

  if formatter then
    formatter()
  else
    -- Default action for other filetypes
    vim.cmd("Conform")
  end
end, { desc = "Format code" })

map("n", " r", function()
  local runners = {
    lua = "lua",
    python = "python",
    go = "go run",
    sh = "sh",
    javascript = "node",
  }

  local filetype = vim.bo.filetype
  local runner = runners[filetype]

  if runner then
    vim.cmd(string.format("bo 20sp | terminal %s %%", runner))
  else
    print("No runner configured for filetype: " .. filetype)
  end
end, { desc = "Run file" })
