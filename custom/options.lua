local opt = vim.opt
local g = vim.g

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
opt.mouse = "v"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true
opt.ruler = false
