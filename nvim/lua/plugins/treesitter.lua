local M = {}

function M.setup()
  local ok, treesitter = pcall(require, "nvim-treesitter")
  if not ok then
    return
  end

  local ok_config, ts_config = pcall(require, "nvim-treesitter.config")
  local ok_install, ts_install = pcall(require, "nvim-treesitter.install")
  if not ok_config or not ok_install then
    return
  end

  local ensure_installed = {
    "bash",
    "c",
    "cpp",
    "css",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "vim",
    "yaml",
  }

  local function notify(msg, level)
    local hl = "MoreMsg"
    if level == vim.log.levels.WARN then
      hl = "WarningMsg"
    elseif level == vim.log.levels.ERROR then
      hl = "ErrorMsg"
    end
    vim.api.nvim_echo({ { "[treesitter] " .. msg, hl } }, true, {})
    vim.notify(msg, level or vim.log.levels.INFO, { title = "treesitter" })
  end

  local function is_installed(lang)
    return vim.list_contains(ts_config.get_installed(), lang)
  end

  local function report_install_result(langs)
    local missing = {}
    for _, lang in ipairs(langs) do
      if not is_installed(lang) then
        table.insert(missing, lang)
      end
    end

    if #missing == 0 then
      notify("TSInstall 完成: " .. table.concat(langs, ", "))
      return
    end

    notify("TSInstall 失败或未安装: " .. table.concat(missing, ", ") .. "（用 :TSLog / :checkhealth nvim-treesitter 查看详情）",
      vim.log.levels.ERROR)
  end

  local function install_with_notify(args, opts)
    local langs = args.fargs
    if #langs == 0 then
      notify("请提供语言，例如 :TSInstall lua", vim.log.levels.WARN)
      return
    end

    notify("开始安装 parser: " .. table.concat(langs, ", "))
    local ok_install_cmd, err = pcall(ts_install.install, langs, opts)
    if not ok_install_cmd then
      notify("TSInstall 命令执行失败: " .. tostring(err), vim.log.levels.ERROR)
      return
    end

    vim.defer_fn(function()
      report_install_result(langs)
    end, 3500)
  end

  local function complete_available(arglead)
    return vim.tbl_filter(function(v)
      return v:find(arglead) ~= nil
    end, ts_config.get_available())
  end

  -- nvim-treesitter 已迁移到 main 分支的新 API：
  --   * require('nvim-treesitter').setup() 只接受 install_dir，不再处理
  --     ensure_installed / highlight / indent / textobjects；
  --   * 安装 parser 用 require('nvim-treesitter').install()，但它需要 PATH 中存在
  --     0.26.1+ 的 tree-sitter CLI（brew 的 tree-sitter 仅含库，CLI 是 tree-sitter-cli）；
  --   * 高亮由 Neovim 内置的 vim.treesitter.start() 负责；
  --   * textobjects 需要单独 require('nvim-treesitter-textobjects').setup()。
  if vim.fn.executable("tree-sitter") == 1 then
    treesitter.install(ensure_installed)
  else
    vim.schedule(function()
      vim.notify_once(
        "nvim-treesitter: 未找到 tree-sitter CLI，已跳过 parser 自动安装。\n请安装 tree-sitter-cli（brew install tree-sitter-cli）后重试，或手动 :TSInstall <lang>。",
        vim.log.levels.WARN
      )
    end)
  end

  local ts_group = vim.api.nvim_create_augroup("hjkl01_treesitter", { clear = true })

  -- 为有 parser 的 filetype 开启 treesitter 高亮（大文件跳过）
  vim.api.nvim_create_autocmd("FileType", {
    group = ts_group,
    callback = function(args)
      local buf = args.buf
      local name = vim.api.nvim_buf_get_name(buf)
      local ok_stat, stats = pcall(vim.uv.fs_stat, name)
      if ok_stat and stats and stats.size and stats.size > 100 * 1024 then
        return -- 100KB 以上不做 treesitter 高亮
      end
      pcall(vim.treesitter.start, buf)
    end,
  })

  -- textobjects（新 API 需要手动映射）
  local ok_textobjects, textobjects = pcall(require, "nvim-treesitter-textobjects")
  if ok_textobjects then
    textobjects.setup({ select = { lookahead = true } })
    local select_textobject = require("nvim-treesitter-textobjects.select").select_textobject
    local selects = {
      ["af"] = { "@function.outer", "Function outer" },
      ["if"] = { "@function.inner", "Function inner" },
      ["ac"] = { "@class.outer", "Class outer" },
      ["ic"] = { "@class.inner", "Class inner" },
    }
    for lhs, spec in pairs(selects) do
      vim.keymap.set({ "x", "o" }, lhs, function()
        select_textobject(spec[1], "textobjects")
      end, { desc = spec[2] })
    end
  end

  local function register_install_commands()
    pcall(vim.api.nvim_del_user_command, "TSInstall")
    vim.api.nvim_create_user_command("TSInstall", function(args)
      install_with_notify(args, { force = args.bang, summary = true })
    end, {
      nargs = "+",
      bang = true,
      bar = true,
      complete = complete_available,
      desc = "Install treesitter parsers with notifications",
    })

    pcall(vim.api.nvim_del_user_command, "TSInstallFromGrammar")
    vim.api.nvim_create_user_command("TSInstallFromGrammar", function(args)
      install_with_notify(args, {
        generate = true,
        summary = true,
        force = args.bang,
      })
    end, {
      nargs = "+",
      bang = true,
      bar = true,
      complete = complete_available,
      desc = "Install parsers from grammar with notifications",
    })
  end

  register_install_commands()
  vim.schedule(register_install_commands)

  local group = vim.api.nvim_create_augroup("hephaestus_tsinstall_notify", { clear = true })
  vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter" }, {
    group = group,
    once = true,
    callback = register_install_commands,
  })
end

return M
