return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "antoinemadec/FixCursorHold.nvim",
    "marilari88/neotest-vitest",
    "nvim-neotest/neotest-jest",
  },
  keys = {
    { "<leader>tr", "<cmd>Neotest run<cr>" },
    { "<leader>ti", "<cmd>Neotest output<cr>" },
    { "<leader>ts", "<cmd>Neotest summary<cr>" },
    { "<leader>ta", "<cmd>lua require('neotest').run.run({suite = true})<cr>" },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-vitest"),
        require("neotest-jest"),
      },
    })
  end,
}
