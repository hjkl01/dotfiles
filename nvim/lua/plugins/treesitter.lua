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
    "tsx",
    "typescript",
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

  treesitter.setup({
    ensure_installed = ensure_installed,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100KB 更激进
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        return ok and stats and stats.size > max_filesize
      end,
    },
    indent = { enable = true },
    autotag = { enable = true },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
    },
  })

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
