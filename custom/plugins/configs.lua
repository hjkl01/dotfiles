local M = {}

M.onedark = function()
    -- Lua
    require('onedark').setup {
        -- Main options --
        style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        transparent = true, -- Show/hide background
        term_colors = true, -- Change terminal color as per the selected theme style
        ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
        cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
        -- toggle theme style ---
        toggle_style_key = '<leader>ts', -- Default keybinding to toggle
        toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

        -- Change code style ---
        -- Options are italic, bold, underline, none
        -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
        code_style = {
            comments = 'italic',
            keywords = 'bold',
            functions = 'bold',
            strings = 'none',
            variables = 'none'
        },

        -- Custom Highlights --
        colors = {}, -- Override default colors
        highlights = {}, -- Override highlight groups

        -- Plugins Config --
        diagnostics = {
            darker = true, -- darker colors for diagnostic
            undercurl = true, -- use undercurl instead of underline for diagnostics
            background = true, -- use background color for virtual text
        },
    }

    require('onedark').load()
end

M.mason = {
  ensure_installed = { 
    "python-lsp-server",
    "lua-language-server",
    "typescript-language-server",
    "bash-language-server",
    "prettier",
    "pylint",
    "yapf",
  }, -- not an option from mason.nvim
}

M.treesitter = {
   ensure_installed = {
     "lua",
     "python",
     "bash",
     "javascript",
     "typescript",
   },
}

M.nvimtree = {
   view = {
        width = 25,
        hide_root_folder = false,
        side = "right",
        preserve_window_proportions = false,
        number = true,
        relativenumber = true,
        signcolumn = "yes",
        mappings = {
            custom_only = false,
            list = {
                -- user mappings go here
                { key = "v", action = "vsplit" },
                { key = "s", action = "split" },
            },
        },
   },
}

return M

