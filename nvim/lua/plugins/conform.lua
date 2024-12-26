return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    cmd = { "Conform", "ConformInfo" },
    lazy = true,
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          -- Conform will run multiple formatters sequentially
          python = { "black" },
          -- You can customize some of the format options for the filetype (:help conform.format)
          rust = { "rustfmt", lsp_format = "fallback" },
          -- Conform will run the first available formatter
          javascript = { "prettierd", "prettier", stop_after_first = true },
        },
      })
    end
  }
}
