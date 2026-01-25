return {
  "mfussenegger/nvim-dap",
  lazy = true,
  dependencies = {
    { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
    { "theHamsta/nvim-dap-virtual-text" },
    { "williamboman/mason.nvim" },
  },
  keys = {
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Toggle breakpoint",
    },
    {
      "<leader>dc",
      function()
        require("dap").continue()
      end,
      desc = "Continue",
    },
    {
      "<leader>dC",
      function()
        require("dap").run_to_cursor()
      end,
      desc = "Run to Cursor",
    },
    {
      "<leader>dT",
      function()
        require("dap").terminate()
      end,
      desc = "Terminate",
    },
    {
      "<leader>do",
      function()
        require("dap").step_over()
      end,
      desc = "Step over",
    },
    {
      "<leader>di",
      function()
        require("dap").step_into()
      end,
      desc = "Step into",
    },
    {
      "<leader>dO",
      function()
        require("dap").step_out()
      end,
      desc = "Step out",
    },
    {
      "<leader>de",
      function()
        require("dapui").eval()
      end,
      mode = { "n", "v" },
      desc = "Evaluate expression",
    },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Virtual text: show variable values inline
    require("nvim-dap-virtual-text").setup({
      commented = true, -- Show as comment (e.g., `-- x = 5`)
    })

    -- Setup dapui
    dapui.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open({ reset = true })
      -- Override K to evaluate during debug sessions
      vim.keymap.set({ "n", "v" }, "K", function()
        dapui.eval()
      end, { desc = "Evaluate expression (DAP)" })
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
      -- Restore K to default (LSP hover)
      pcall(vim.keymap.del, { "n", "v" }, "K")
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
      -- Restore K to default (LSP hover)
      pcall(vim.keymap.del, { "n", "v" }, "K")
    end

    -- Get js-debug-adapter path from Mason
    local js_debug_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"
    if vim.fn.filereadable(js_debug_path) == 0 then
      vim.notify("js-debug-adapter not installed. Run :MasonInstall js-debug-adapter", vim.log.levels.WARN)
      return
    end

    -- JavaScript/TypeScript Node adapter (Mason's js-debug-adapter)
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = { js_debug_path, "${port}" },
      },
    }

    -- Chrome adapter for browser debugging
    dap.adapters["pwa-chrome"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = { js_debug_path, "${port}" },
      },
    }

    -- JavaScript and TypeScript configurations
    for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
      dap.configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to Node",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Launch Chrome (localhost:3000)",
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
        },
        {
          type = "pwa-chrome",
          request = "attach",
          name = "Attach to Chrome",
          port = 9222,
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
        },
      }
    end
  end,
}
