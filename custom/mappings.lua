local M = {}

M.disabled = {
  n = {
    ["<leader>h"] = "",
    ["<C-s>"] = "",
    ["<C-c>"] = "",
    ["<leader>n"] = "",
    ["<leader>rn"] = "",
    ["<leader>uu"] = "",
    ["<leader>tt"] = "",
  }
}

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
        ["#"] = { "* <CR>", "next ident" },

        -- switch between windows
        ["<C-h>"] = { "<C-w>h", " window left" },
        ["<C-l>"] = { "<C-w>l", " window right" },
        ["<C-j>"] = { "<C-w>j", " window down" },
        ["<C-k>"] = { "<C-w>k", " window up" },

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
                        exec ":Neoformat <CR>"
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

M.comment = {

    -- toggle comment in both modes
    n = {
        -- ["<leader>/"] = {
        ["//"] = {
            function()
                require("Comment.api").toggle.linewise.current()
            end,
            "蘒  toggle comment",
        },
    },

    v = {
        ["//"] = {
            '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>',
            "蘒  toggle comment",
        },
    },
}

M.lspconfig = {

  n = {
    ["<leader>f"] = {
      function()
        vim.lsp.buf.formatting {}
      end,
      "lsp formatting",
    },
    },

}

M.nvimtree = {
    n = {
        ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "   toggle nvimtree" },
    },
}

return M
