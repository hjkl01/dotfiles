local M = {}
local did_setup = false

function M.setup()
  if did_setup then
    return
  end

  vim.pack.add({
    -- Core / shared libs
    { src = "https://github.com/nvim-lua/plenary.nvim",                       name = "plenary.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons",                 name = "nvim-web-devicons" },
    { src = "https://github.com/MunifTanjim/nui.nvim",                        name = "nui.nvim" },

    -- UI / appearance
    { src = "https://github.com/catppuccin/nvim",                             name = "catppuccin" },
    { src = "https://github.com/folke/tokyonight.nvim",                       name = "tokyonight.nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim",                   name = "lualine.nvim" },
    { src = "https://github.com/akinsho/bufferline.nvim",                     name = "bufferline.nvim" },
    { src = "https://github.com/folke/noice.nvim",                            name = "noice.nvim" },
    { src = "https://github.com/folke/which-key.nvim",                        name = "which-key.nvim" },

    -- File explorer / navigation
    { src = "https://github.com/folke/flash.nvim",                            name = "flash.nvim" },
    { src = "https://github.com/nvim-neo-tree/neo-tree.nvim",                 name = "neo-tree.nvim",              version = "v3.x" },

    -- LSP / syntax / diagnostics
    { src = "https://github.com/mason-org/mason.nvim",                        name = "mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim",              name = "mason-lspconfig.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig",                       name = "nvim-lspconfig" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter",             name = "nvim-treesitter" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", name = "nvim-treesitter-textobjects" },
    { src = "https://github.com/windwp/nvim-ts-autotag",                      name = "nvim-ts-autotag" },
    { src = "https://github.com/mfussenegger/nvim-lint",                      name = "nvim-lint" },
    { src = "https://github.com/folke/trouble.nvim",                          name = "trouble.nvim" },

    -- Editing / completion / snippets
    { src = "https://github.com/Saghen/blink.cmp",                            name = "blink.cmp",                  version = "v1.10.2" },
    { src = "https://github.com/stevearc/conform.nvim",                       name = "conform.nvim" },
    { src = "https://github.com/rafamadriz/friendly-snippets",                name = "friendly-snippets" },
    { src = "https://github.com/folke/ts-comments.nvim",                      name = "ts-comments.nvim" },
    { src = "https://github.com/nvim-mini/mini.nvim",                         name = "mini.nvim" },
    { src = "https://github.com/nvim-mini/mini.ai",                           name = "mini.ai" },
    { src = "https://github.com/nvim-mini/mini.icons",                        name = "mini.icons" },
    { src = "https://github.com/nvim-mini/mini.pairs",                        name = "mini.pairs" },

    -- Search / project tools
    { src = "https://github.com/ibhagwan/fzf-lua",                            name = "fzf-lua" },
    { src = "https://github.com/MagicDuck/grug-far.nvim",                     name = "grug-far.nvim" },
    { src = "https://github.com/folke/todo-comments.nvim",                    name = "todo-comments.nvim" },
    { src = "https://github.com/folke/snacks.nvim",                           name = "snacks.nvim" },

    -- Git / session
    { src = "https://github.com/lewis6991/gitsigns.nvim",                     name = "gitsigns.nvim" },
    { src = "https://github.com/folke/persistence.nvim",                      name = "persistence.nvim" },

    -- AI / language helpers
    { src = "https://github.com/folke/lazydev.nvim",                          name = "lazydev.nvim" },
    { src = "https://github.com/github/copilot.vim",                          name = "copilot.vim",                version = "release" },
    { src = "https://github.com/Exafunction/windsurf.vim",                    name = "windsurf.vim" },

    -- Utility
    { src = "https://github.com/voldikss/vim-translator",                     name = "vim-translator" },
  }, {
    load = false,
    confirm = false,
  })

  did_setup = true
end

return M
