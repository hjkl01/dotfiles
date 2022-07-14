return {

    ['vim-autoformat/vim-autoformat'] = {
        config = function()
            vim.g.autoformat_autoindent = 1
            vim.g.autoformat_retab = 1
            vim.g.autoformat_remove_trailing_spaces = 1
        end,
    },

    ['voldikss/vim-translator'] = {
        config = function()
            vim.g.translator_default_engines = { 'haici', 'youdao', 'bing' }
        end,
    },

    ['navarasu/onedark.nvim'] = {
        config = function()
            require("custom.plugins.smolconfigs").onedark()
        end,
    },


}
