local map = vim.keymap.set

local function remap_comment_keys()
  local gc_normal = vim.fn.maparg("gc", "n", false, true)
  local gc_visual = vim.fn.maparg("gc", "x", false, true)
  local gcc = vim.fn.maparg("gcc", "n", false, true)

  if type(gcc) == "table" and type(gcc.callback) == "function" then
    map("n", "<leader>/", gcc.callback, { expr = true, desc = "Toggle comment line" })
  end

  if type(gc_visual) == "table" and type(gc_visual.callback) == "function" then
    map("x", "<leader>/", gc_visual.callback, { expr = true, desc = "Toggle comment selection" })
  end

  if type(gc_normal) == "table" and type(gc_normal.callback) == "function" then
    map("n", "<leader>?", gc_normal.callback, { expr = true, desc = "Toggle comment operator" })
  end

  pcall(vim.keymap.del, "n", "gcc")
  pcall(vim.keymap.del, "n", "gc")
  pcall(vim.keymap.del, "x", "gc")
end

remap_comment_keys()

map("i", "<C-b>", "<ESC>^i", { desc = "beginning of line", remap = true })
map("i", "<C-e>", "<End>", { desc = "end of line", remap = true })

-- 开始定义快捷键映射
map("n", "<ESC>", ":noh<CR>", { desc = "no highlight" })
map({ "n", "v" }, "H", "0", { desc = "Home" })
map({ "n", "v" }, "L", "$", { desc = "End" })
map("n", "q", "<cmd>q<CR>", { desc = "﬚  quit file" })
map("n", "W", "<cmd>w<CR>", { desc = "﬚  save file" })
map("n", "#", "*<CR>", { desc = "next ident" })
map("n", "<leader>u", function() vim.pack.update() end, { desc = "Update vim.pack plugins" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })

map("i", "<C-h>", "<Left>", { desc = "move left", remap = true })
map("i", "<C-l>", "<Right>", { desc = "move right", remap = true })
map("i", "<C-j>", "<Down>", { desc = "move down", remap = true })
map("i", "<C-k>", "<Up>", { desc = "move up", remap = true })

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
