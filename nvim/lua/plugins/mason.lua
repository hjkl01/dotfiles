return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "lua-language-server",
        -- "stylua",
        "ruff",
        "prettier",
        "fixjson",
        -- "yamlfmt",
        -- "shfmt",
        -- "black",
        "python-lsp-server",
        -- "bash-language-server",
        "typescript-language-server",
        -- "gopls",
      })
    end,
  },
}
