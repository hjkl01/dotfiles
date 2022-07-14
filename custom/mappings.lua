local M = {}

M.general = {

    i = {
        -- go to  beginning and end
        ["<C-b>"] = { "<ESC>^i", "論 beginning of line" },
        ["<C-e>"] = { "<End>", "壟 end of line" },

        -- navigate within insert mode
        ["<C-h>"] = { "<Left>", "  move left" },
        ["<C-l>"] = { "<Right>", " move right" },
        ["<C-j>"] = { "<Down>", " move down" },
        ["<C-k>"] = { "<Up>", " move up" },
    },

    v = {
        ["H"] = { "0", "Home" },
        ["L"] = { "$", "End" },
    },

    n = {

        -- ["<esc>"] = { ":nohl<cr>", "Home" },
        ["<ESC>"] = { "<cmd> noh <CR>", "  no highlight" },

        ["H"] = { "0", "Home" },
        ["L"] = { "$", "End" },
        -- ["q"] = { ":q<CR>", "quit" },
        ["q"] = { "<cmd> q <CR>", "﬚  quit file" },
        -- ["W"] = { ":w<CR>", "save" },
        ["W"] = { "<cmd> w <CR>", "﬚  save file" },
        ["n"] = { "N", "search" },
        ["N"] = { "n", "search" },

        -- switch between windows
        ["<C-h>"] = { "<C-w>h", " window left" },
        ["<C-l>"] = { "<C-w>l", " window right" },
        ["<C-j>"] = { "<C-w>j", " window down" },
        ["<C-k>"] = { "<C-w>k", " window up" },

    },

}

M.others = {
    n = {
        ["ff"] = {
            function()
                -- echo &filetype
                vim.cmd [[
                    exec "w"
                    if &filetype == 'python'
                        exec "r !black -l 120 -q %"
                        " exec "r !yapf -i %"
                        exec "e"
                    elseif &filetype == 'json'
                        exec "%!python3 -c 'import json, sys, collections; print(json.dumps(json.load(sys.stdin, object_pairs_hook=collections.OrderedDict), ensure_ascii=False, indent=4))'"
                    else
                        exec ":Autoformat <CR>"
                        exec "w"
                    endif
                ]]
            end,
            "autoformat" },

        [' r'] = {
            function()
                vim.cmd [[ 
                    exec "w"
                    if &filetype == 'python'
                        "exec "!time python %"
                        exec ':bo 20sp | terminal python %'
                    elseif &filetype == 'go'
                        exec ':bo 10sp | terminal go run %'
                    elseif &filetype == 'sh'
                        exec ':bo 10sp | terminal sh %'
                    elseif &filetype == 'javascript'
                        exec ':bo 10sp | terminal node %'
                    else
                        echo &filetype
                    endif
                ]]
            end,
            "run file"
        }

    },
}

M.translate = {
    n = {
        ["tt"] = { "<Plug>TranslateW", "TranslateW" },
    },
    v = {
        ["tt"] = { "<Plug>TranslateWV", "TranslateWV" },
    },
}

return M
