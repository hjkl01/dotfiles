return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false,
      term_colors = false,
      dim_inactive = {
        enabled = false,
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
      lsp_styles = {
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
          ok = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
          ok = { "underline" },
        },
        inlay_hints = {
          background = true,
        },
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        bufferline = true,
        fzf = true,
        telescope = true,
        snacks = true,
        neotree = true,
        flash = true,
        which_key = true,
        indent_blankline = { enabled = true },
        aerial = true,
        dashboard = true,
        grug_far = true,
        headlines = true,
        illuminate = true,
        leap = true,
        lsp_trouble = true,
        mason = true,
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        noice = true,
        treesitter_context = true,
      },
      color_overrides = {},
      custom_highlights = function(colors)
        return {
          Comment = { fg = colors.flamingo },
        }
      end,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        vim.cmd.colorscheme("catppuccin-nvim")
      end,
    },
  },
}
