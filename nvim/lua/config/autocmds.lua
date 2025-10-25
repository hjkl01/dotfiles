-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")


-- 自动高亮光标下的单词
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  pattern = "*",
  callback = function()
    -- 获取光标下的单词
    local word = vim.fn.expand('<cword>')
    if not word or word == '' then return end

    -- 清除之前的匹配
    vim.fn.clearmatches()

    -- 添加高亮（使用 Search 组，你也可以用 Visual 自定义高亮组）
    vim.fn.matchadd('Search', '\\<' .. vim.fn.escape(word, '\\/') .. '\\>')
  end,
})
