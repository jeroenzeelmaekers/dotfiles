return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      dependencies = {
        "nvim-neotest/nvim-nio",
      },
      config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()

        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close()
        end
      end,
    },
  },
  keys = {
    {
      "<F5>",
      function()
        require("dap").continue()
      end,
      desc = "Debug continue",
    },
    {
      "<F10>",
      function()
        require("dap").step_over()
      end,
      desc = "Debug step over",
    },
    {
      "<F11>",
      function()
        require("dap").step_into()
      end,
      desc = "Debug step into",
    },
    {
      "<F12>",
      function()
        require("dap").step_out()
      end,
      desc = "Debug step out",
    },
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Debug toggle breakpoint",
    },
    {
      "<leader>du",
      function()
        require("dapui").toggle()
      end,
      desc = "Debug toggle UI",
    },
  },
}
