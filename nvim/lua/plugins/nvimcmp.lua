return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
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

      -- Completion Sources
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "Saghen/blink.cmp",

      -- UI/Icons
      "onsails/lspkind.nvim",
    },
    opts = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      local options = {
        completion = {
          -- `noselect` means the completion menu will not pre-select the first item.
          completeopt = "menu,menuone,noselect",
        },
        view = {
          entries = { name = "custom", selection_order = "near_cursor" },
        },
        window = {
          completion = {
            side_padding = 1,
            winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
            scrollbar = true,
          },
          documentation = {
            border = "rounded", -- A simpler border
            winhighlight = "Normal:CmpDoc",
          },
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        -- Replace the huge color table with lspkind
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text", -- show symbol and text
            maxwidth = 50, -- prevent the popup from becoming too wide
            ellipsis_char = "...",
            -- Show source name
            before = function(entry, vim_item)
              vim_item.menu = "[" .. entry.source.name .. "]"
              return vim_item
            end,
          }),
        },
        mapping = {
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          -- Correctly handle snippet navigation
          ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              require("luasnip").expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "blink" },
          { name = "nvim_lua" },
          { name = "path" },
        }),
      }

      return options
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },
}
