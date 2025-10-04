local vim = vim

return {
  -- Snippet Engine & Snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = "rafamadriz/friendly-snippets",
    config = function()
      local luasnip = require("luasnip")
      luasnip.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
      })
      -- load snippets
      require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.luasnippets_path or "" })
      require("luasnip.loaders.from_vscode").lazy_load()
      -- unlink snippet on leaving insert mode
      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          if luasnip.session.current_nodes[vim.api.nvim_get_current_buf()] and not luasnip.session.jump_active then
            luasnip.unlink_current()
          end
        end,
      })
    end,
  },

  -- Completion Engine
  {
    "Saghen/blink.cmp",
    event = "InsertEnter",
    version = "1.*",
    opts = function()

      local kind_map = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "ﴲ",
        Variable = "",
        Class = "ﴯ",
        Interface = "",
        Module = "",
        Property = "ﰠ",
        Unit = "塞",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "醙",
        Operator = "",
        TypeParameter = "",
      }

      local options = {
        completion = {
          completeopt = "menu,menuone,noselect",
        },
        view = {
          entries = { name = "custom", selection_order = "near_cursor" },
        },
        snippets = {
          preset = "luasnip",
        },
        keymap = {
          ["<C-u>"] = { "scroll_documentation_up" },
          ["<C-d>"] = { "scroll_documentation_down" },
          ["<C-Space>"] = { "show" },
          ["<C-e>"] = { "hide" },
          ["<CR>"] = { "accept", accept_behavior = "insert" },
          ["<C-n>"] = { "select_next", "snippet_forward", "fallback" },
          ["<C-p>"] = { "select_prev", "snippet_backward", "fallback" },
        },
        sources = {
          default = { "path", "lsp", "buffer", "snippets" },
        },
        appearance = {
          menu = {
            border = "rounded",
            winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
            scrollbar = true,
            side_padding = 1,
            draw = {
              columns = {
                { "kind_icon", "label", gap = 1 },
                { "source_name" },
              },
              components = {
                kind_icon = {
                  text = function(item)
                    return (kind_map[item.kind] or "") .. " "
                  end,
                  highlight = "CmpItemKind",
                },
                label = {
                  text = function(item)
                    return item.label
                  end,
                  highlight = "CmpItemAbbr",
                  max_width = 50,
                  ellipsis = "...",
                },
                source_name = {
                  text = function(ctx)
                    return "[" .. ctx.source_name .. "]"
                  end,
                  highlight = "CmpItemMenu",
                },
              },
            },
          },
          documentation = {
            border = "rounded",
            winhighlight = "Normal:CmpDoc",
          },
        },
        signature = { enabled = true },
      }
      return options
    end,
    config = function(_, opts)
      require("blink.cmp").setup(opts)
    end,
  },
}
