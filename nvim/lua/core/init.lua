local opt = vim.opt
local g = vim.g
local config = require("core.utils").load_config()

-------------------------------------- globals -----------------------------------------
g.toggle_theme_icon = "   "
g.transparency = config.ui.transparency

-------------------------------------- options ------------------------------------------
opt.laststatus = 3 -- global statusline
opt.showmode = false

opt.clipboard = "unnamedplus"
opt.cursorline = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "v"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true
opt.ruler = false

-- disable nvim intro
opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

g.mapleader = " "

-- 折叠
opt.foldenable = false
opt.foldmethod = "indent"

-- 补全增强
opt.wildmenu = true
-- 当文件被外部程序修改时，自动加载
opt.autoread = true
-- 边输入边搜索
opt.incsearch = true
opt.hidden = true
opt.ignorecase = true
opt.smartcase = true

-- disable some default providers
for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. vim.fn.stdpath "data" .. "/mason/bin"

-------------------------------------- autocmds ------------------------------------------
local autocmd = vim.api.nvim_create_autocmd

-- dont list quickfix buffers
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

local sep = vim.loop.os_uname().sysname:find "windows" and "\\" or "/"

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = vim.fn.glob(
    table.concat({
      vim.fn.stdpath "config",
      "lua",
      "custom",
      "**",
      "*.lua",
    }, sep),
    true,
    true,
    true
  ),

  group = vim.api.nvim_create_augroup("ReloadNvChad", {}),

  callback = function(opts)
    require("plenary.reload").reload_module "base46"
    local file = string
      .gsub(vim.fn.fnamemodify(opts.file, ":r"), vim.fn.stdpath "config" .. sep .. "lua" .. sep, "")
      :gsub(sep, ".")
    require("plenary.reload").reload_module(file)
    require("plenary.reload").reload_module "custom.chadrc"

    config = require("core.utils").load_config()

    vim.opt.statusline = "%!v:lua.require('nvchad_ui.statusline." .. config.ui.statusline.theme .. "').run()"

    require("base46").load_all_highlights()
    -- vim.cmd("redraw!")
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

-- 高亮当前单词 影响光标
-- vim.cmd [[
--     autocmd CursorMoved * exe printf('match Cursor /\V\<%s\>/', escape(expand('<cword>'), '/\'))
--     " IncSearch
-- ]]
