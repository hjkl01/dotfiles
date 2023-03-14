local options = {
  filters = {
    dotfiles = false,
    exclude = { vim.fn.stdpath "config" .. "/lua/custom" },
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,
  },
  view = {
    width = 25,
    hide_root_folder = false,
    side = "right",
    preserve_window_proportions = false,
    number = true,
    relativenumber = true,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {
        -- user mappings go here
        { key = "v", action = "vsplit" },
        { key = "s", action = "split" },
      },
    },
  },
  git = {
    enable = true,
    ignore = false,
  },
  filesystem_watchers = {
    enable = true,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
}

vim.g.nvimtree_side = options.view.side

return options
