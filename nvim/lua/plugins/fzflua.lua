return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    cmd = "FzfLua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})
    end
  }
}
