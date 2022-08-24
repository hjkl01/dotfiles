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
    -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

    n = {
        ["gD"] = {
            function()
                vim.lsp.buf.declaration()
            end,
            "   lsp declaration",
        },

        ["gd"] = {
            function()
                vim.lsp.buf.definition()
            end,
            "   lsp definition",
        },

        ["K"] = {
            function()
                vim.lsp.buf.hover()
            end,
            "   lsp hover",
        },

        ["gi"] = {
            function()
                vim.lsp.buf.implementation()
            end,
            "   lsp implementation",
        },

        ["<C-k>"] = {
            function()
                vim.lsp.buf.signature_help()
            end,
            "   lsp signature_help",
        },

        ["<leader>D"] = {
            function()
                vim.lsp.buf.type_definition()
            end,
            "   lsp definition type",
        },

        ["<leader>ra"] = {
            function()
                vim.lsp.buf.rename()
            end,
            "   lsp rename",
        },

        ["<leader>ca"] = {
            function()
                vim.lsp.buf.code_action()
            end,
            "   lsp code_action",
        },

        ["gr"] = {
            function()
                vim.lsp.buf.references()
            end,
            "   lsp references",
        },

        -- ["<leader>f"] = {
        --    function()
        --       vim.diagnostic.open_float()
        --    end,
        --    "   floating diagnostic",
        -- },

        ["[d"] = {
            function()
                vim.diagnostic.goto_prev()
            end,
            "   goto prev",
        },

        ["d]"] = {
            function()
                vim.diagnostic.goto_next()
            end,
            "   goto_next",
        },

        ["<leader>q"] = {
            function()
                vim.diagnostic.setloclist()
            end,
            "   diagnostic setloclist",
        },

        -- ["<space>f"] = {
        --   function()
        --     vim.lsp.buf.formatting {}
        --   end,
        --   "lsp formatting",
        -- },

        [" f"] = {
            function()
                if (vim.version()["minor"] < 8) then
                    -- if vim.version().minor > 7 then
                    -- if vim.fn.has('nvim-0.8') == 0 then
                    vim.lsp.buf.formatting()
                else
                    vim.lsp.buf.format()
                end
            end,
            "   lsp formatting ",
        },

        ["<leader>wa"] = {
            function()
                vim.lsp.buf.add_workspace_folder()
            end,
            "   add workspace folder",
        },

        ["<leader>wr"] = {
            function()
                vim.lsp.buf.remove_workspace_folder()
            end,
            "   remove workspace folder",
        },

        ["<leader>wl"] = {
            function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            "   list workspace folders",
        },
    },
}

M.nvimtree = {
    n = {
        ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "   toggle nvimtree" },
    },
}

return M
