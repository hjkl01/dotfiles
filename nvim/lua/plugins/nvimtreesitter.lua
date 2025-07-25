return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        "lua",
        "python",
        "go",
        "javascript",
        "typescript",
        "bash",
        "yaml",
        "toml",
        "json",
        "xml",
        "html",
      },
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      indent = { enable = true },
      folding = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.install").prefer_git = true
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
