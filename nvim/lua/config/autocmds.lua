-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- 自动高亮光标下的单词 (优化性能)
local highlight_timer = nil
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = function()
    if highlight_timer then
      vim.loop.timer_stop(highlight_timer)
    end
    highlight_timer = vim.loop.new_timer()
    highlight_timer:start(
      200,
      0,
      vim.schedule_wrap(function()
        -- 获取光标下的单词
        local word = vim.fn.expand("<cword>")
        if not word or word == "" or #word < 3 then
          return
        end

        -- 清除之前的匹配
        vim.fn.clearmatches()

        -- 添加高亮（使用 Search 组）
        vim.fn.matchadd("Search", "\\<" .. vim.fn.escape(word, "\\/") .. "\\>")
      end)
    )
  end,
})
