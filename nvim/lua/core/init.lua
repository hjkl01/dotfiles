-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. vim.fn.stdpath "data" .. "/mason/bin"

-- autocmds
local autocmd = vim.api.nvim_create_autocmd

-- dont list quickfix buffers
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- wrap the PackerSync command to warn people before using it in NvChadSnapshots
autocmd("VimEnter", {
  callback = function()
    vim.cmd "command! -nargs=* -complete=customlist,v:lua.require'packer'.plugin_complete PackerSync lua require('plugins') require('core.utils').packer_sync(<f-args>)"
  end,
})

-- Disable statusline in dashboard
autocmd("FileType", {
  pattern = "alpha",
  callback = function()
    vim.opt.laststatus = 0
  end,
})

autocmd("BufUnload", {
  buffer = 0,
  callback = function()
    vim.opt.laststatus = 3
  end,
})

-- open nvim with a dir while still lazy loading nvimtree
-- autocmd("BufEnter", {
--    callback = function()
--       if vim.api.nvim_buf_get_option(0, "buftype") ~= "terminal" then
--          vim.cmd "lcd %:p:h"
--       end
--    end,
-- })

-- Use relative & absolute line numbers in 'n' & 'i' modes respectively
-- autocmd("InsertEnter", {
--    callback = function()
--       vim.opt.relativenumber = false
--    end,
-- })
-- autocmd("InsertLeave", {
--    callback = function()
--       vim.opt.relativenumber = true
--    end,
-- })

-- Open a file from its last left off position
autocmd("BufReadPost", {
  callback = function()
    if not vim.fn.expand("%:p"):match ".git" and vim.fn.line "'\"" > 1 and vim.fn.line "'\"" <= vim.fn.line "$" then
      vim.cmd "normal! g'\""
      vim.cmd "normal zz"
    end
  end,
})

-- File extension specific tabbing
-- autocmd("Filetype", {
--    pattern = "python",
--    callback = function()
--       vim.opt_local.expandtab = true
--       vim.opt_local.tabstop = 4
--       vim.opt_local.shiftwidth = 4
--       vim.opt_local.softtabstop = 4
--    end,
-- })

-- Highlight yanked text
autocmd("TextYankPost", {
  callback = function()
    -- vim.highlight.on_yank { higroup = "IncSearch", timeout = 1000 }
    vim.highlight.on_yank { higroup = "Cursor", timeout = 500 }
  end,
})

-- Enable spellchecking in markdown, text and gitcommit files
-- autocmd("FileType", {
--    pattern = { "gitcommit", "markdown", "text" },
--    callback = function()
--       vim.opt_local.spell = true
--    end,
-- })

-- nvim-tree 自动关闭
autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match "NvimTree_" ~= nil then
      vim.cmd "quit"
    end
    vim.opt.formatoptions = vim.opt.formatoptions
      - "o" -- O and o, don't continue comments
      + "r" -- But do continue when pressing enter.
  end,
})

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

vim.cmd [[
    autocmd CursorMoved * exe printf('match Cursor /\V\<%s\>/', escape(expand('<cword>'), '/\'))
    " IncSearch 
]]

local LspFormat = function()
  -- return vim.lsp.buf.formatting_sync()
  if vim.version()["minor"] < 8 then
    -- if vim.version().minor > 7 then
    -- if vim.fn.has('nvim-0.8') == 0 then
    return vim.lsp.buf.formatting()
  else
    return vim.lsp.buf.format()
  end
end
vim.api.nvim_create_user_command("LspFormat", LspFormat, {})
