return {
  {
    "nvim-treesitter/nvim-treesitter",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.install").prefer_git = true
      -- for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
      -- -- config.install_info.url = config.install_info.url:gsub("https://github.com/", "https://gh.hjkl01.cn/proxy/https://github.com/")
      -- config.install_info.url = config.install_info.url:gsub("https://github.com/", vim.fn.getenv("GITHUB_MIRROR") .. "/https://github.com/")
      -- end

      require("nvim-treesitter.configs").setup({
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
        }
      })
    end,
  }
}
