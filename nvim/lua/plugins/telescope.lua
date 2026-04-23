local M = {}
local did_setup = false

local function ensure_loaded()
  if did_setup then
    return true
  end

  if not require("config.pack").load("telescope.nvim") then
    return false
  end

  require("telescope").setup({
    defaults = {
      layout_strategy = "horizontal",
      layout_config = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      sorting_strategy = "ascending",
      winblend = 0,
      path_display = { "smart" },
    },
    pickers = {
      find_files = {
        hidden = true,
      },
      live_grep = {
        additional_args = function()
          return { "--hidden" }
        end,
      },
    },
  })

  did_setup = true
  return true
end

local function builtin(name, opts)
  return function()
    if ensure_loaded() then
      require("telescope.builtin")[name](opts or {})
    end
  end
end

function M.setup()
  vim.keymap.set("n", "<leader><leader>", builtin("find_files"), { desc = "Find Files" })
  vim.keymap.set("n", "<leader>fg", builtin("live_grep"), { desc = "Live Grep" })
  vim.keymap.set("n", "<leader>fb", builtin("buffers"), { desc = "Buffers" })
  vim.keymap.set("n", "<leader>fh", builtin("help_tags"), { desc = "Help Tags" })
end

return M
