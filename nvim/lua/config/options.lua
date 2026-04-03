-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

-- SSH 远程时：yank 通过 OSC52 同步到 macOS 剪贴板，paste 走内部寄存器（避免延迟）
if os.getenv("SSH_CONNECTION") or os.getenv("SSH_CLIENT") then
  vim.o.clipboard = "unnamedplus"
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = function() end,
      ["*"] = function() end,
    },
  }
end
