local vim = vim

return {
  {
    "folke/tokyonight.nvim",
    enabled = false, -- Disabled, uncomment to enable
    lazy = false,    -- 确保尽早加载
    priority = 1000,
    opts = {
      style = "storm",    -- 或 "moon", "night", "day"
      transparent = true, -- 🌟 关键：启用透明背景
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
      },
      sidebars = {
        "qf",
        "help",
        "terminal",
        "startuptime",
        "packer",
        "nvim-tree",
        "neo-tree",
        "toggleterm",
        "lazy",
        "mason",
        "notify",
        "noice",
      },
    },

    config = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    "catppuccin/nvim",
    -- enabled = false, -- Disabled, uncomment to enable
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = true,
      show_end_of_buffer = true,
      term_colors = true,
      dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = false,
      no_bold = false,
      no_underline = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      color_overrides = {},
      custom_highlights = function(colors)
        return {
          LineNr = { fg = colors.text },
        }
      end,
      integrations = {
        blink_cmp = true,
        gitsigns = true,
        telescope = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      -- setup must be called before loading
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
