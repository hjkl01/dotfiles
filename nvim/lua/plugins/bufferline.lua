return {
  {
    "akinsho/bufferline.nvim",
    -- enable = false,
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<TAB>", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
      { "<S-TAB>", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
    },
    opts = {
      options = {
        -- Example options:
        -- diagnostics = "nvim_lsp",
        -- always_show_bufferline = true,
      },
    },
    config = function(_, opts)
      -- NOTE: vim.opt.termguicolors = true is a global setting
      -- and should be set in a central options file, not here.
      require("bufferline").setup(opts)
    end,
  },
}

