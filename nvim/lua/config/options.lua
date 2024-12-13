-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
-- local g = vim.g

opt.laststatus = 3 -- global statusline
-- 当文件被外部程序修改时，自动加载
opt.autoread = true
-- 补全增强
opt.wildmenu = true
opt.incsearch = true

vim.o.linebreak = true
vim.o.wrap = true
