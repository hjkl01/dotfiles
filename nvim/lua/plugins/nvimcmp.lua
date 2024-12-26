return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        config = function()
          local options = { history = true, updateevents = "TextChanged,TextChangedI" }

          require("luasnip").config.set_config(options)

          require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.luasnippets_path or "" }
          require("luasnip.loaders.from_vscode").lazy_load()

          vim.api.nvim_create_autocmd("InsertLeave", {
            callback = function()
              if
                  require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
                  and not require("luasnip").session.jump_active
              then
                require("luasnip").unlink_current()
              end
            end,
          })
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      local cmp = require "cmp"

      local function border(hl_name)
        return {
          { "╭", hl_name },
          { "─", hl_name },
          { "╮", hl_name },
          { "│", hl_name },
          { "╯", hl_name },
          { "─", hl_name },
          { "╰", hl_name },
          { "│", hl_name },
        }
      end

      local options = {
        completion = {
          completeopt = "menu,menuone",
        },
        view = {
          -- entries = "custom", -- can be "custom", "wildmenu" or "native"
          entries = { name = "custom", selection_order = "near_cursor" },
        },
        window = {
          completion = {
            -- side_padding = (cmp_style ~= "atom" and cmp_style ~= "atom_colored") and 1 or 0,
            side_padding = 1,
            winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
            scrollbar = true,
          },
          documentation = {
            border = border "CmpDocBorder",
            winhighlight = "Normal:CmpDoc",
          },
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        formatting = {
          PmenuSel = { bg = "#282C34", fg = "NONE" },
          Pmenu = { fg = "#C5CDD9", bg = "#22252A" },
          CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE", fmt = "strikethrough" },
          CmpItemAbbrMatch = { fg = "#82AAFF", bg = "NONE", fmt = "bold" },
          CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bg = "NONE", fmt = "bold" },
          CmpItemMenu = { fg = "#C792EA", bg = "NONE", fmt = "italic" },
          CmpItemKindField = { fg = "#EED8DA", bg = "#B5585F" },
          CmpItemKindProperty = { fg = "#EED8DA", bg = "#B5585F" },
          CmpItemKindEvent = { fg = "#EED8DA", bg = "#B5585F" },
          CmpItemKindText = { fg = "#C3E88D", bg = "#9FBD73" },
          CmpItemKindEnum = { fg = "#C3E88D", bg = "#9FBD73" },
          CmpItemKindKeyword = { fg = "#C3E88D", bg = "#9FBD73" },
          CmpItemKindConstant = { fg = "#FFE082", bg = "#D4BB6C" },
          CmpItemKindConstructor = { fg = "#FFE082", bg = "#D4BB6C" },
          CmpItemKindReference = { fg = "#FFE082", bg = "#D4BB6C" },
          CmpItemKindFunction = { fg = "#EADFF0", bg = "#A377BF" },
          CmpItemKindStruct = { fg = "#EADFF0", bg = "#A377BF" },
          CmpItemKindClass = { fg = "#EADFF0", bg = "#A377BF" },
          CmpItemKindModule = { fg = "#EADFF0", bg = "#A377BF" },
          CmpItemKindOperator = { fg = "#EADFF0", bg = "#A377BF" },
          CmpItemKindVariable = { fg = "#C5CDD9", bg = "#7E8294" },
          CmpItemKindFile = { fg = "#C5CDD9", bg = "#7E8294" },
          CmpItemKindUnit = { fg = "#F5EBD9", bg = "#D4A959" },
          CmpItemKindSnippet = { fg = "#F5EBD9", bg = "#D4A959" },
          CmpItemKindFolder = { fg = "#F5EBD9", bg = "#D4A959" },
          CmpItemKindMethod = { fg = "#DDE5F5", bg = "#6C8ED4" },
          CmpItemKindValue = { fg = "#DDE5F5", bg = "#6C8ED4" },
          CmpItemKindEnumMember = { fg = "#DDE5F5", bg = "#6C8ED4" },
          CmpItemKindInterface = { fg = "#D8EEEB", bg = "#58B5A8" },
          CmpItemKindColor = { fg = "#D8EEEB", bg = "#58B5A8" },
          CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "#58B5A8" },
        },
        mapping = {
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              require("luasnip").expand_or_jumpable()
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
          ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              require("luasnip").jumpable(-1)
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "nvim_lua" },
          { name = "path" },
        },
      }

      return options
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  }
}
