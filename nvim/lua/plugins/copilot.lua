return {
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      -- vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap("i", "<C-g>", 'copilot#Accept("<CR>")', { silent = true, expr = true, script = true })
      -- vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true, script = true })
      -- vim.api.nvim_set_keymap("i", "<C-]>", 'copilot#Next()', { silent = true, expr = true, script = true })
      -- vim.api.nvim_set_keymap("i", "<C-[>", 'copilot#Previous()', { silent = true, expr = true, script = true })
      -- vim.api.nvim_set_keymap("i", "<C-\\>", 'copilot#Suggest()', { silent = true, expr = true, script = true })
    end
  }
}
