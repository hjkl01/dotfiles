return {
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap-python",
      -- "leoluz/nvim-dap-go",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      require("dap-python").setup("~/.venv/py3/bin/python")
      -- pip install debugpy

      -- require("dap-go").setup()
      -- go install github.com/go-delve/delve/cmd/dlv@latest


      -- 快捷键绑定
      local map = vim.keymap.set
      map("n", "<leader>dc", function() dap.continue() end, { desc = "启动调试" })
      map("n", "<leader>do", function() dap.step_over() end, { desc = "跳过" })
      map("n", "<leader>di", function() dap.step_into() end, { desc = "进入函数" })
      map("n", "<leader>dt", function() dap.step_out() end, { desc = "跳出函数" })
      map("n", "<leader>de", function() dapui.eval(vim.fn.input("Expr: ")) end, { desc = "查看变量（浮窗）" })
      map("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "切换断点" })
      map("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "设置条件断点" })
      map("n", "<leader>du", function() dapui.toggle() end, { desc = "切换 dap-ui 面板" })
    end,
  },
}
