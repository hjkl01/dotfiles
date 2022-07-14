local autocmd = vim.api.nvim_create_autocmd
local new_cmd = vim.api.nvim_create_user_command
local opt = vim.opt

-- autocmds

-- 高亮单词
vim.cmd [[
    autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
]]

-- Highlight yanked text
autocmd("TextYankPost", {
   callback = function()
      vim.highlight.on_yank { higroup = "Visual", timeout = 1000 }
   end,
})

-- nvim-tree 自动关闭
autocmd("BufEnter", {
   nested = true,
   callback = function()
      if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
         vim.cmd("quit")
      end
      vim.opt.formatoptions = vim.opt.formatoptions
      - "o" -- O and o, don't continue comments
      + "r" -- But do continue when pressing enter.
   end,
})

-- commands

-- I dont use shade.nvim/autosave.nvim all the time so made commands for them
-- So this makes easy to lazy load them at cmds

-- new_cmd("EnableShade", function()
--    require("shade").setup()
-- end, {})
--
-- new_cmd("EnableAutosave", function()
--    require("autosave").setup()
-- end, {})
