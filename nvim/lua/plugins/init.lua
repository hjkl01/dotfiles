local plugins_ui = require "plugins.ui"
local plugins_code = require "plugins.code"

local plugins = {
  ["lewis6991/impatient.nvim"] = {
    config = function()
      require "impatient"
    end,
  },

  ["wbthomason/packer.nvim"] = {
    cmd = require("core.lazy_load").packer_cmds,
    config = function()
      require "plugins"
    end,
  },

  ["nvim-lua/plenary.nvim"] = {},

  ["echasnovski/mini.nvim"] = {
    config = function()
      require "plugins.configs.mini"
    end,
  },

  ["voldikss/vim-translator"] = {
    config = function()
      vim.g.translator_default_engines = { "haici", "youdao", "bing" }
    end,
  },

  ["iamcco/markdown-preview.nvim"] = {
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
}

for k, v in pairs(plugins_ui) do
  plugins[k] = v
end

for k, v in pairs(plugins_code) do
  plugins[k] = v
end

-- Load all plugins
local present, packer = pcall(require, "packer")

if present then
  vim.cmd "packadd packer.nvim"

  -- Override with default plugins with user ones
  plugins = require("core.utils").merge_plugins(plugins)

  -- load packer init options
  local init_options = require("plugins.configs.others").packer_init()
  init_options = require("core.utils").load_override(init_options, "wbthomason/packer.nvim")
  packer.init(init_options)

  for _, v in pairs(plugins) do
    packer.use(v)
  end
end
