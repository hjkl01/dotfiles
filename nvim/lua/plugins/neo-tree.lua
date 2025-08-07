return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "\\", ":Neotree reveal<CR>", desc = "NeoTree: Reveal file" },
      { "<leader>e", ":Neotree toggle<CR>", desc = "NeoTree: Toggle" },
    },
    config = function()
      -- Define icons for diagnostics
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
    end,
  },
}
