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
    local function set_neotest_highlights()
      -- Reload melange palette for current background
      package.loaded["melange/palettes/dark"] = nil
      package.loaded["melange/palettes/light"] = nil
      local melange = require("melange/palettes/" .. vim.opt.background:get())

      -- Status highlights (sign column + summary)
      vim.api.nvim_set_hl(0, "NeotestPassed", { fg = melange.b.green })
      vim.api.nvim_set_hl(0, "NeotestFailed", { fg = melange.b.red })
      vim.api.nvim_set_hl(0, "NeotestRunning", { fg = melange.b.yellow })
      vim.api.nvim_set_hl(0, "NeotestSkipped", { fg = melange.b.magenta })
      vim.api.nvim_set_hl(0, "NeotestUnknown", { fg = melange.a.ui })
      vim.api.nvim_set_hl(0, "NeotestWatching", { fg = melange.b.yellow })

      -- Summary pane structure
      vim.api.nvim_set_hl(0, "NeotestAdapterName", { fg = melange.b.red, bold = true })
      vim.api.nvim_set_hl(0, "NeotestDir", { fg = melange.b.cyan })
      vim.api.nvim_set_hl(0, "NeotestFile", { fg = melange.b.cyan })
      vim.api.nvim_set_hl(0, "NeotestNamespace", { fg = melange.b.magenta })
      vim.api.nvim_set_hl(0, "NeotestTest", { fg = melange.a.fg })
      vim.api.nvim_set_hl(0, "NeotestFocused", { bold = true, underline = true })
      vim.api.nvim_set_hl(0, "NeotestMarked", { fg = melange.c.yellow, bold = true })
      vim.api.nvim_set_hl(0, "NeotestTarget", { fg = melange.b.red })
      vim.api.nvim_set_hl(0, "NeotestIndent", { fg = melange.a.ui })
      vim.api.nvim_set_hl(0, "NeotestExpandMarker", { fg = melange.a.ui })
      vim.api.nvim_set_hl(0, "NeotestWinSelect", { fg = melange.b.cyan, bold = true })
      vim.api.nvim_set_hl(0, "NeotestBorder", { fg = melange.a.ui })
    end

    -- Set highlights on load
    set_neotest_highlights()

    -- Re-apply when colorscheme changes (light/dark toggle)
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = set_neotest_highlights,
    })

    require("neotest").setup({
      adapters = {
        require("neotest-vitest"),
        require("neotest-jest"),
      },
    })
  end,
}
