return {
  {
    "nvim-mini/mini.nvim",
    config = function()
      require("mini.trailspace").setup({
        filetypes = { "*" },
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function()
          require("mini.trailspace").trim()
        end,
      })
    end,
  },
}
