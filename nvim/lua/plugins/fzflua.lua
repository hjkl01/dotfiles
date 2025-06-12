return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    cmd = "FzfLua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})

      -- FzfLua
      vim.keymap.set('n', 'gd',
        '<cmd>FzfLua lsp_definitions     jump_to_single_result=true silent=true ignore_current_line=true<cr>',
        { desc = "Goto Definition" })
      vim.keymap.set('n', 'gr', '<cmd>FzfLua lsp_references      jump_to_single_result=true ignore_current_line=true<cr>',
        { desc = "References" })
      vim.keymap.set('n', 'gI', '<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>',
        { desc = "Goto Implementation" })
      vim.keymap.set('n', 'gy', '<cmd>FzfLua lsp_typedefs        jump_to_single_result=true ignore_current_line=true<cr>',
        { desc = "Goto T[y]pe Definition" })
    end
  }
}
