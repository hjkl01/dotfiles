local M = {}

function M.setup()
  local ok, ts_configs = pcall(require, "nvim-treesitter.configs")
  if not ok then
    return
  end

  require("nvim-treesitter.install").compilers = { "gcc" }
  require("nvim-treesitter.install").prefer_git = true
  local ts_config = require("nvim-treesitter.config")
  local parsers = require("nvim-treesitter.parsers")

  ts_configs.setup({
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    autotag = {
      enable = true,
    },
  })

  local installing = {}
  local group = vim.api.nvim_create_augroup("hephaestus_treesitter_auto_install", { clear = true })

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function(args)
      local ft = args.match
      if not ft or ft == "" then
        return
      end

      local lang = vim.treesitter.language.get_lang(ft) or ft
      if not parsers[lang] then
        return
      end

      local targets = ts_config.norm_languages({ lang }, { unsupported = true })
      local installed = ts_config.get_installed("parsers")
      local pending = {}

      for _, item in ipairs(targets) do
        if not vim.list_contains(installed, item) and not installing[item] then
          table.insert(pending, item)
        end
      end

      for _, item in ipairs(pending) do
        installing[item] = true
        vim.schedule(function()
          local ok_install = pcall(vim.cmd, "silent! TSInstall " .. item)
          if not ok_install then
            vim.notify("treesitter parser install failed: " .. item, vim.log.levels.WARN)
          end
          installing[item] = nil
        end)
      end
    end,
  })
end

return M
