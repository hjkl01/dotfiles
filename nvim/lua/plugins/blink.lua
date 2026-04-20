local M = {}

function M.setup()
  local function try_blink_build()
    pcall(vim.cmd, "silent! BlinkCmp build")
  end

  local function looks_broken(err)
    if type(err) ~= "string" then
      return false
    end
    return err:find("module 'blink%.cmp' not found", 1, false) ~= nil
  end

  local ok, blink = pcall(require, "blink.cmp")
  if not ok then
    if looks_broken(blink) then
      local pack = vim.pack.get()
      for _, plugin in ipairs(pack) do
        if plugin.spec and plugin.spec.name == "blink.cmp" and plugin.path then
          local reset_ok = vim.fn.system({ "git", "-C", plugin.path, "reset", "--hard", "HEAD" })
          if vim.v.shell_error ~= 0 then
            vim.notify("blink.cmp repair failed: " .. tostring(reset_ok), vim.log.levels.ERROR)
            try_blink_build()
            return
          end
          local clean_ok = vim.fn.system({ "git", "-C", plugin.path, "clean", "-fd" })
          if vim.v.shell_error ~= 0 then
            vim.notify("blink.cmp repair failed: " .. tostring(clean_ok), vim.log.levels.ERROR)
            try_blink_build()
            return
          end
          package.loaded["blink.cmp"] = nil
          ok, blink = pcall(require, "blink.cmp")
          if ok then
            try_blink_build()
          end
          break
        end
      end
    end
  end

  if not ok then
    vim.notify("blink.cmp load failed: " .. tostring(blink), vim.log.levels.ERROR)
    return
  end

  blink.setup({
    keymap = { preset = "enter" },
    appearance = {
      nerd_font_variant = "mono",
    },
    completion = {
      documentation = { auto_show = true },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = {
      implementation = "lua",
    },
  })
end

return M
