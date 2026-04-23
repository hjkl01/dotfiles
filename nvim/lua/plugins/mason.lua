local M = {}

function M.setup()
  require("mason").setup({
    PATH = "prepend",
    max_concurrent_installers = 10,
    github = {
      download_url_template = "https://gh.hjkl01.cn/https://github.com/%s/releases/download/%s/%s",
    },
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  })

  local mason_lspconfig = require("mason-lspconfig")
  local lsp_servers = { "gopls", "lua_ls", "ruff", "pylsp" }

  mason_lspconfig.setup({
    ensure_installed = lsp_servers,
    automatic_enable = false,
  })

  local capabilities = require("blink.cmp").get_lsp_capabilities()

  vim.lsp.config("gopls", {
    capabilities = capabilities,
  })

  vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
      },
    },
  })

  vim.lsp.config("ruff", {
    capabilities = capabilities,
    init_options = {
      settings = {
        lineLength = 180,
      },
    },
    on_attach = function(client)
      client.server_capabilities.hoverProvider = true
    end,
  })

  vim.lsp.config("pylsp", {
    capabilities = capabilities,
    settings = {
      pylsp = {
        plugins = {
          autopep8 = { enabled = false },
          mccabe = { enabled = false },
          pycodestyle = { enabled = false },
          pyflakes = { enabled = false },
          pylint = { enabled = false },
          ruff = { enabled = false },
          yapf = { enabled = false },
        },
      },
    },
  })

  local installed_lsp_servers = mason_lspconfig.get_installed_servers()
  vim.lsp.enable(vim.tbl_filter(function(server)
    return vim.tbl_contains(lsp_servers, server)
  end, installed_lsp_servers))

  vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(event)
      if vim.bo[event.buf].buftype ~= "" then
        return
      end

      local clients = vim.lsp.get_clients({
        bufnr = event.buf,
        method = "textDocument/formatting",
      })
      if vim.tbl_isempty(clients) then
        return
      end

      vim.lsp.buf.format({
        async = false,
        bufnr = event.buf,
        timeout_ms = 2000,
      })
    end,
  })

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Goto References" })
  vim.keymap.set("n", "<leader>fm", function()
    vim.lsp.buf.format({ async = false, timeout_ms = 2000 })

    local buf_name = vim.api.nvim_buf_get_name(0)
    local is_normal_file = vim.bo.buftype == ""
    if is_normal_file and buf_name ~= "" then
      vim.cmd.write()
    end
  end, { desc = "Format and Save" })
end

return M
