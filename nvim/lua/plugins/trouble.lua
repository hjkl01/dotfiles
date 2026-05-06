local M = {}
local did_setup = false

local function ensure_loaded()
  if did_setup then
    return true
  end

  if not require("config.pack").load("trouble.nvim") then
    return false
  end

  require("trouble").setup({})
  did_setup = true
  return true
end

function M.setup()
  local last_line = -1
  local last_open_ms = 0
  local float_throttle_ms = 500

  local skip_filetypes = {
    "TelescopePrompt",
    "checkhealth",
    "grug-far",
    "help",
    "lazy",
    "lspinfo",
    "neo-tree",
    "noice",
    "notify",
    "qf",
    "snacks_dashboard",
    "trouble",
  }

  local function should_open_diagnostic_float(buf)
    if not vim.api.nvim_buf_is_valid(buf) then
      return false
    end

    if vim.bo[buf].buftype ~= "" then
      return false
    end

    local filetype = vim.bo[buf].filetype
    if filetype ~= "" and vim.tbl_contains(skip_filetypes, filetype) then
      return false
    end

    local buf_name = vim.api.nvim_buf_get_name(buf)
    if buf_name == "" then
      return false
    end

    local ok, stats = pcall(vim.uv.fs_stat, buf_name)
    if ok and stats and stats.size and stats.size > 256 * 1024 then
      return false
    end

    if vim.api.nvim_get_mode().mode:sub(1, 1) == "i" then
      return false
    end

    return vim.api.nvim_get_current_win() == vim.fn.bufwinid(buf)
  end

  vim.keymap.set("n", "<leader>xx", function()
    if ensure_loaded() then
      vim.cmd("Trouble diagnostics toggle")
    end
  end, { desc = "Diagnostics (Trouble)" })

  vim.keymap.set("n", "<leader>xq", function()
    if ensure_loaded() then
      vim.cmd("Trouble qflist toggle")
    end
  end, { desc = "Quickfix (Trouble)" })

  vim.api.nvim_create_autocmd("CursorHold", {
    callback = function(event)
      if not should_open_diagnostic_float(event.buf) then
        last_line = -1
        return
      end

      local line = vim.api.nvim_win_get_cursor(0)[1]
      if line == last_line then
        return
      end
      last_line = line

      local diagnostics = vim.diagnostic.get(0, { lnum = line - 1 })

      for _, d in ipairs(diagnostics) do
        if d.severity == vim.diagnostic.severity.ERROR then
          local now = vim.uv.now()
          if now - last_open_ms < float_throttle_ms then
            return
          end
          last_open_ms = now
          vim.diagnostic.open_float(nil, {
            focus = false,
            scope = "cursor",
            close_events = { "CursorMoved", "CursorMovedI", "BufLeave", "InsertEnter", "FocusLost" },
          })
          return
        end
      end
    end,
  })
end

return M
