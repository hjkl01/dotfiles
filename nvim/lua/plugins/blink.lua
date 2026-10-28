local M = {}

function M.setup()
  local ok, blink = pcall(require, "blink.cmp")
  if not ok then
    vim.notify("blink.cmp load failed: " .. tostring(blink), vim.log.levels.ERROR)
    return
  end

  blink.setup({
    keymap = { preset = "enter" },
    appearance = {
      nerd_font_variant = "mono",
    },
    completion = {
      documentation = { auto_show = true },
    },
    cmdline = {
      -- 注意：blink.cmp v1.10+ 的 cmdline.enabled 只接受 boolean，
      -- 不能用函数。控制“搜索 (/ ?) 时不弹补全菜单”应改用
      -- cmdline.completion.menu.auto_show（见下方）。
      enabled = true,
      keymap = {
        preset = "cmdline",
        -- 不要用 select_accept_and_enter：菜单打开时它会“选中第一项再回车”，
        -- 导致输入 :w 回车变成 :wq。改成只在用户显式选中时才接受。
        ["<CR>"] = { "accept_and_enter", "fallback" },
        ["<TAB>"] = { "select_and_accept", "fallback" },
        ["<C-e>"] = { "cancel", "fallback" },
      },
      completion = {
        list = {
          selection = {
            -- 关闭预选和自动插入：否则输入 :w 时会把历史/命令补全的首项
            -- （通常是 :wq）直接写进命令行，回车即执行 :wq。
            -- 需要补全时用 <TAB> 或 <C-n>/<C-p> 选择。
            preselect = false,
            auto_insert = false,
          },
        },
        menu = {
          -- 只在 : 命令模式自动弹出补全；/ 和 ? 搜索时不弹，
          -- 避免自动插入已有单词（这是官方推荐的写法）
          auto_show = function()
            return vim.fn.getcmdtype() == ":"
          end,
        },
      },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = {
      -- 官方推荐值：优先 Rust 实现，在支持的平台自动下载预编译库，失败时回退 Lua。
      -- 之前强制 "lua" 会禁用 Rust，使 :BlinkCmp build 那套自修逻辑变得自相矛盾。
      implementation = "prefer_rust_with_warning",
    },
  })
end

return M
