-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("i", "<C-b>", "<ESC>^i", { desc = "beginning of line", remap = true })
map("i", "<C-e>", "<End>", { desc = "end of line", remap = true })
map("i", "<C-h>", "<Left>", { desc = "move left", remap = true })
map("i", "<C-l>", "<Right>", { desc = "move right", remap = true })
map("i", "<C-j>", "<Down>", { desc = "move down", remap = true })
map("i", "<C-k>", "<Up>", { desc = "move up", remap = true })

-- 开始定义快捷键映射
map('n', '<ESC>', ':noh<CR>', { desc = "no highlight" })
map({ 'n', 'v' }, 'H', '0', { desc = "Home" })
map({ 'n', 'v' }, 'L', '$', { desc = "End" })
map('n', 'q', '<cmd>q<CR>', { desc = "﬚  quit file" })
map('n', 'W', '<cmd>w<CR>', { desc = "﬚  save file" })
map('n', '#', '*<CR>', { desc = "next ident" })

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })


map("n", "ff", function()
    local fileType = vim.o.filetype
    print(fileType)
    if fileType == "python" then
      vim.cmd [[r !black -l 120 -q %]]
    elseif fileType == "json" then
      vim.cmd [[%!python3 -c 'import json, sys, collections; print(json.dumps(json.load(sys.stdin, object_pairs_hook=collections.OrderedDict), ensure_ascii=False, indent=4))']]
    else
      -- vim.cmd('Neoformat')
      vim.cmd('Conform')
    end
  end,
  { desc = "autoformat" })

map("n", " r", function()
    local fileType = vim.o.filetype
    print(fileType)
    if fileType == "lua" then
      vim.cmd [[ :bo 20sp | terminal lua %]]
    elseif fileType == "python" then
      vim.cmd [[ :bo 20sp | terminal python %]]
    elseif fileType == "go" then
      vim.cmd [[ :bo 20sp | terminal go run %]]
    elseif fileType == "sh" then
      vim.cmd [[ :bo 20sp | terminal sh %]]
    elseif fileType == "javascript" then
      vim.cmd [[ :bo 20sp | terminal node %]]
    else
      print(fileType)
    end
  end,
  { desc = "run file" }
)
