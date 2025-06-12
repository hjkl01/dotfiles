return {
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      vim.opt.termguicolors = true
      require("bufferline").setup()

      vim.keymap.set('n', '<TAB>', "<cmd> BufferLineCycleNext <CR>", { desc = "BufferLineCycleNext" })
      vim.keymap.set('n', '<s-TAB>', "<cmd> BufferLineCyclePrev <CR>", { desc = "BufferLineCyclePrev" })
    end,
  }
}
