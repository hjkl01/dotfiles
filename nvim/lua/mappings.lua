-- n, v, i, t = mode names

local M = {}

M.general = {
  i = {
    -- go to  beginning and end
    ["<C-b>"] = { "<ESC>^i", "beginning of line" },
    ["<C-e>"] = { "<End>", "end of line" },
    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "move left" },
    ["<C-l>"] = { "<Right>", "move right" },
    ["<C-j>"] = { "<Down>", "move down" },
    ["<C-k>"] = { "<Up>", "move up" },
  },
  n = {
    ["<ESC>"] = { "<cmd> noh <CR>", "no highlight" },
    ["H"] = { "0", "Home" },
    ["L"] = { "$", "End" },
    -- ["q"] = { ":q<CR>", "quit" },
    ["q"] = { "<cmd> q <CR>", "﬚  quit file" },
    -- ["W"] = { ":w<CR>", "save" },
    ["W"] = { "<cmd> w <CR>", "﬚  save file" },
    ["#"] = { "* <CR>", "next ident" },
    -- switch between windows
    ["<C-h>"] = { "<C-w>h", "window left" },
    ["<C-l>"] = { "<C-w>l", "window right" },
    ["<C-j>"] = { "<C-w>j", "window down" },
    ["<C-k>"] = { "<C-w>k", "window up" },
    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    ["ff"] = {
      function()
        local fileType = vim.o.filetype
        print(fileType)
        if fileType == "python" then
          vim.cmd [[r !black -l 120 -q %]]
        elseif fileType == "json" then
          vim.cmd [[%!python3 -c 'import json, sys, collections; print(json.dumps(json.load(sys.stdin, object_pairs_hook=collections.OrderedDict), ensure_ascii=False, indent=4))']]
        else
          vim.cmd('Neoformat')
        end
      end,
      "autoformat",
    },
    [" r"] = {
      function()
        local fileType = vim.o.filetype
        print(fileType)
        if fileType == "lua" then
          vim.cmd [[ :bo 20sp | terminal lua %]]
        elseif fileType == "python" then
          vim.cmd [[ :bo 20sp | terminal python %]]
        elseif fileType == "go" then
          vim.cmd [[ :bo 20sp | terminal go run %]]
        elseif fileType == "sh" then
          vim.cmd [[ :bo 20sp | terminal sh %]]
        elseif fileType == "javascript" then
          vim.cmd [[ :bo 20sp | terminal node %]]
        else
          print(fileType)
        end
      end,
      "run file",
    },
  },
  v = {
    ["H"] = { "0", "Home" },
    ["L"] = { "$", "End" },
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
  },
  x = {
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', opts = { silent = true } },
  },
}

M.lspconfig = {
  plugin = true,
  n = {
    ["gd"] = { "<cmd>FzfLua lsp_definitions     jump_to_single_result=true ignore_current_line=true<cr>", "Goto Definition" },
    ["gr"] = { "<cmd>FzfLua lsp_references      jump_to_single_result=true ignore_current_line=true<cr>", "References" },
    ["gI"] = { "<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>", "Goto Implementation" },
    ["gy"] = { "<cmd>FzfLua lsp_typedefs        jump_to_single_result=true ignore_current_line=true<cr>", "Goto T[y]pe Definition" },
  },
}

M.bufferline = {
  plugin = true,
  n = {
    ["<TAB>"] = { "<cmd> BufferLineCycleNext <CR>", "BufferLineCycleNext" },
    ["<s-TAB>"] = { "<cmd> BufferLineCyclePrev <CR>", "BufferLineCyclePrev" },
  },
}

M.neotree = {
  plugin = true,
  n = {
    ["<leader>e"] = { "<cmd> Neotree <CR>", "" },
  },
}

M.telescope = {
  plugin = true,
  n = {
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Telescope find files" },
    ["<leader>fg"] = { "<cmd> lua require('telescope.builtin').live_grep() <cr>", "Telescope live grep" },
    -- git
    ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "git status" },
  },
}

M.whichkey = {
  plugin = true,
  n = {
    ["<leader>wK"] = {
      function()
        vim.cmd "WhichKey"
      end,
      "which-key all keymaps",
    },
    ["<leader>wk"] = {
      function()
        local input = vim.fn.input "WhichKey: "
        vim.cmd("WhichKey " .. input)
      end,
      "which-key query lookup",
    },
  },
}

M.translate = {
  n = {
    ["tt"] = { "<cmd> TranslateW <CR>", "translate window" },
  },
  v = {
    -- ["tt"] = { "<cmd> Translate ZH <CR>", "translate zh" },
    ["tt"] = { "<cmd> TranslateW <CR>", "translate in visual model" },
  },
}
return M
