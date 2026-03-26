return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "gruvbox",
        callback = function()
          local hi = vim.api.nvim_set_hl
          hi(0, "Normal", { bg = "none" })
          hi(0, "NormalFloat", { bg = "none" })
          hi(0, "LineNr", { bg = "none" })
          hi(0, "Folded", { bg = "none" })
          hi(0, "NonText", { bg = "none" })
          hi(0, "EndOfBuffer", { bg = "none" })
        end,
      })
    end,
  },
}
