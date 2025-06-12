return {
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "nvim-neotest/nvim-nio"
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      require("dap-python").setup("~/.venv/py3/bin/python")

      -- 快捷键绑定
      local map = vim.keymap.set
      map("n", "<leader>bs", function() dap.continue() end, { desc = "启动调试" })
      map("n", "<F10>", function() dap.step_over() end, { desc = "跳过" })
      map("n", "<F11>", function() dap.step_into() end, { desc = "进入函数" })
      map("n", "<F12>", function() dap.step_out() end, { desc = "跳出函数" })
      map("n", "<leader>bb", function() dap.toggle_breakpoint() end, { desc = "切换断点" })
      map("n", "<leader>B", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "设置条件断点" })
      map("n", "<leader>du", function() dapui.toggle() end, { desc = "切换 dap-ui 面板" })
    end,
  },
}
