-------------------------------------- autocmds ------------------------------------------
local autocmd = vim.api.nvim_create_autocmd

-- dont list quickfix buffers
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

autocmd("BufUnload", {
  buffer = 0,
  callback = function()
    vim.opt.laststatus = 3
  end,
})

-- Highlight yanked text
autocmd("TextYankPost", {
  callback = function()
    -- vim.highlight.on_yank { higroup = "IncSearch", timeout = 1000 }
    vim.highlight.on_yank { higroup = "Cursor", timeout = 500 }
  end,
})

-- Return last position
autocmd({ 'BufWinEnter' }, {
  desc = 'return cursor to where it was last time closing the file',
  pattern = '*',
  command = 'silent! normal! g`"zv',
})
