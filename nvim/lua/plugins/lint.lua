local M = {}

function M.setup()
  local lint = require("lint")
  local has = vim.fn.executable

  local lua_linters = {}
  if has("selene") == 1 then
    table.insert(lua_linters, "selene")
  end

  local python_linters = {}
  if has("ruff") == 1 then
    table.insert(python_linters, "ruff")
  end

  local sh_linters = {}
  if has("shellcheck") == 1 then
    table.insert(sh_linters, "shellcheck")
  end

  lint.linters_by_ft = {
    python = python_linters,
    lua = lua_linters,
    sh = sh_linters,
  }

  vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
    callback = function()
      lint.try_lint()
    end,
  })
end

return M
