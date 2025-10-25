-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Highlight word under cursor
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  callback = function()
    if vim.g.current_match_id then
      vim.fn.matchdelete(vim.g.current_match_id)
      vim.g.current_match_id = nil
    end
    local word = vim.fn.expand("<cword>")
    if word ~= "" and #word > 1 then
      vim.g.current_match_id = vim.fn.matchadd("Search", "\\<" .. vim.fn.escape(word, "\\") .. "\\>")
    end
  end,
})
