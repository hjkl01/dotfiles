-------------------------------------- autocmds ------------------------------------------
local autocmd = vim.api.nvim_create_autocmd

-- dont list quickfix buffers
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- Disable statusline in dashboard
-- autocmd("FileType", {
--   pattern = "alpha",
--   callback = function()
--     vim.opt.laststatus = 0
--   end,
-- })

autocmd("BufUnload", {
  buffer = 0,
  callback = function()
    vim.opt.laststatus = 3
  end,
})

-- Open a file from its last left off position
autocmd(
  "BufReadPost",
  { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

-- autocmd("BufReadPost", {
--   callback = function()
--     if not vim.fn.expand("%:p"):match ".git" and vim.fn.line "'\"" > 1 and vim.fn.line "'\"" <= vim.fn.line "$" then
--       vim.cmd "normal! g'\""
--       vim.cmd "normal zz"
--     end
--   end,
-- })
-- local api = vim.api
-- autocmd({ "BufRead", "BufReadPost" }, {
--   callback = function()
--     local row, column = unpack(api.nvim_buf_get_mark(0, '"'))
--     local buf_line_count = api.nvim_buf_line_count(0)
--
--     if row >= 1 and row <= buf_line_count then
--       api.nvim_win_set_cursor(0, { row, column })
--     end
--   end,
-- })

-- Highlight yanked text
autocmd("TextYankPost", {
  callback = function()
    -- vim.highlight.on_yank { higroup = "IncSearch", timeout = 1000 }
    vim.highlight.on_yank { higroup = "Cursor", timeout = 500 }
  end,
})

-- autocmd("BufEnter", {
--   nested = true,
--   callback = function()
--     if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match "NvimTree_" ~= nil then
--       vim.cmd "quit"
--     end
--     vim.opt.formatoptions = vim.opt.formatoptions
--         - "o" -- O and o, don't continue comments
--         + "r" -- But do continue when pressing enter.
--   end,
-- })

-- auto format before save file
-- autocmd("BufWritePre", {
--     -- pattern = { "*.py", "*.sh", "*.lua" },
--     -- callback = function()
--     --     vim.lsp.buf.formatting()
--     --     <cmd> w <CR>
--     -- end,
--
--     callback = function()
--         vim.cmd("Neoformat")
--     end,
-- })

-- 高亮当前单词 影响光标
-- vim.cmd [[
--     autocmd CursorMoved * exe printf('match Cursor /\V\<%s\>/', escape(expand('<cword>'), '/\'))
--     " IncSearch
-- ]]

-- -- nvim-tree 自动关闭
-- -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
-- vim.api.nvim_create_autocmd("BufEnter", {
--   group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
--   pattern = "NvimTree_*",
--   callback = function()
--     local layout = vim.api.nvim_call_function("winlayout", {})
--     if
--       layout[1] == "leaf"
--       and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
--       and layout[3] == nil
--     then
--       vim.cmd "confirm quit"
--     end
--   end,
-- })

-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",
--   callback = function(args)
--     require("conform").format { bufnr = args.buf }
--   end,
-- })
