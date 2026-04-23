local M = {}
local did_setup = false

local function configure()
  if did_setup then
    return true
  end

  if not require("config.pack").load("neo-tree.nvim") then
    return false
  end

  vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
  vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
  vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
  vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

  require("neo-tree").setup({
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    default_component_configs = {
      indent = {
        with_expanders = true,
        expander_collapsed = "",
        expander_expanded = "",
      },
      git_status = {
        symbols = {
          added = "A",
          modified = "M",
          deleted = "D",
          renamed = "R",
          untracked = "U",
          ignored = "I",
          unstaged = " unstaged ",
          staged = " staged ",
          conflict = "C",
        },
      },
    },
    window = {
      position = "right",
      width = 40,
      mappings = {
        ["<cr>"] = "open",
        ["l"] = "open",
        ["S"] = "open_split",
        ["s"] = "open_vsplit",
        ["t"] = "open_tabnew",
        ["a"] = "add",
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy",
        ["m"] = "move",
        ["q"] = "close_window",
        ["R"] = "refresh",
        ["?"] = "show_help",
      },
    },
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = true,
        hide_gitignored = true,
        hide_hidden = true,
        never_show = { ".DS_Store", "Thumbs.db" },
      },
      follow_current_file = {
        enabled = true,
      },
      hijack_netrw_behavior = "open_default",
    },
  })

  did_setup = true
  return true
end

function M.setup()
  vim.keymap.set("n", "<leader>e", function()
    if configure() then
      vim.cmd("Neotree toggle")
    end
  end, { desc = "NeoTree: Toggle" })
end

return M
