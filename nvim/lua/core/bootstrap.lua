local M = {}

M.lazy = function(install_path)
  print "Bootstrapping lazy.nvim .."

  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    install_path,
  }

  vim.opt.rtp:prepend(install_path)

  -- install plugins + compile their configs
  require "plugins"

  vim.api.nvim_buf_delete(0, { force = true }) -- close lazy window

  vim.defer_fn(function()
    vim.cmd "silent! MasonInstallAll"
  end, 0)
end

return M
