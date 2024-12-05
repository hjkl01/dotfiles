-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del("n", "s")

local map = vim.keymap.set

map("i", "<C-b>", "<ESC>^i", { desc = "beginning of line" })
map("i", "<C-e>", "<End>", { desc = "end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

map({ "n", "v" }, "H", "0", { desc = "Home" })
map({ "n", "v" }, "L", "$", { desc = "End" })
map("n", "q", "<cmd> q <CR>", { desc = "ﬁ quit file" })
map("n", "W", "<cmd> w <CR>", { desc = "ﬁ save file" })
map("n", "#", "*<CR>", { desc = "next ident" })

map("n", "ff", function()
  local fileType = vim.o.filetype
  print(fileType)
  if fileType == "python" then
    vim.cmd([[r !black -l 120 -q %]])
  elseif fileType == "json" then
    vim.cmd(
      [[%!python3 -c 'import json, sys, collections; print(json.dumps(json.load(sys.stdin, object_pairs_hook=collections.OrderedDict), ensure_ascii=False, indent=4))']]
    )
  else
    vim.cmd("Neoformat")
  end
end, { desc = "autoformat" })
map("n", " r", function()
  local fileType = vim.o.filetype
  print(fileType)
  if fileType == "lua" then
    vim.cmd([[bo 20sp | terminal lua %]])
  elseif fileType == "python" then
    vim.cmd([[bo 20sp | terminal python %]])
  elseif fileType == "go" then
    vim.cmd([[bo 20sp | terminal go run %]])
  elseif fileType == "sh" then
    vim.cmd([[bo 20sp | terminal sh %]])
  elseif fileType == "javascript" then
    vim.cmd([[bo 20sp | terminal node %]])
  else
    print(fileType)
  end
end, { desc = "run file" })

-- 选择模式下的键映射
map("x", "j", "v:count || mode(1)[0:1] == 'no' ? 'j' : 'gj'", { expr = true, desc = "move down or wrapped lines" })
map("x", "k", "v:count || mode(1)[0:1] == 'no' ? 'k' : 'gk'", { expr = true, desc = "move up or wrapped lines" })
map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { silent = true, desc = "paste without copying replaced text" })

-- bufferline
map("n", "<TAB>", "<cmd>bnext<cr>", { desc = "Prev Buffer" })
map("n", "<s-TAB>", "<cmd>bprevious<cr>", { desc = "Next Buffer" })

-- translate
map("n", "tt", "<cmd> TranslateW <CR>")
map("x", "tt", "<cmd> TranslateW <CR>")
