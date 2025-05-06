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

-- neo-tree
-- vim.keymap.set('n', '<leader>e', function() require("mini.files").open() end, { desc = "Open Mini Files" })
map("n", "<leader>e", "<cmd> Neotree <CR>", { desc = "Open Neo-tree", remap = true })

-- translate
map({ 'n', 'v' }, 'tt', "<cmd> TranslateW <CR>", { desc = "translate window", remap = true })

-- bufferline
map('n', '<TAB>', "<cmd> BufferLineCycleNext <CR>", { desc = "BufferLineCycleNext" })
map('n', '<s-TAB>', "<cmd> BufferLineCyclePrev <CR>", { desc = "BufferLineCyclePrev" })

-- telescope
map('n', "<leader>ff", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
  { desc = "Telescope find files" })
map('n', "<leader>fg", "<cmd> lua require('telescope.builtin').live_grep() <cr>", { desc = "Telescope live grep" })
-- -- git
map('n', "<leader>cm", "<cmd> Telescope git_commits <CR>", { desc = "git commits" })
map('n', "<leader>gt", "<cmd> Telescope git_status <CR>", { desc = "git status" })

-- WhichKey
-- map('n', "<leader>wK", function() vim.cmd "WhichKey" end, { desc = "which-key all keymaps" })
-- map('n', "<leader>wk", function()
--   local input = vim.fn.input "WhichKey: "
--   vim.cmd("WhichKey " .. input)
-- end, { desc = "which-key query lookup" })

-- FzfLua
map('n', 'gd', '<cmd>FzfLua lsp_definitions     jump_to_single_result=true silent=true ignore_current_line=true<cr>',
  { desc = "Goto Definition" })
map('n', 'gr', '<cmd>FzfLua lsp_references      jump_to_single_result=true ignore_current_line=true<cr>',
  { desc = "References" })
map('n', 'gI', '<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>',
  { desc = "Goto Implementation" })
map('n', 'gy', '<cmd>FzfLua lsp_typedefs        jump_to_single_result=true ignore_current_line=true<cr>',
  { desc = "Goto T[y]pe Definition" })
