return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    keys = {
      {
        "gd",
        "<cmd>FzfLua lsp_definitions jump_to_single_result=true silent=true ignore_current_line=true<cr>",
        desc = "Goto Definition",
      },
      {
        "gr",
        "<cmd>FzfLua lsp_references jump_to_single_result=true ignore_current_line=true<cr>",
        desc = "References",
      },
      {
        "gI",
        "<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>",
        desc = "Goto Implementation",
      },
      {
        "gy",
        "<cmd>FzfLua lsp_typedefs jump_to_single_result=true ignore_current_line=true<cr>",
        desc = "Goto T[y]pe Definition",
      },
    },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})
    end,
  },
}
