return {
  "ThePrimeagen/99",
  config = function()
    local _99 = require("99")

    _99.setup({
      model = "github-copilot/claude-opus-4.5",
    })

    -- Fill in function body with AI
    vim.keymap.set("n", "<leader>9f", function()
      _99.fill_in_function()
    end, { desc = "99: Fill in function" })

    -- Visual selection AI completion
    vim.keymap.set("v", "<leader>9v", function()
      _99.visual()
    end, { desc = "99: Visual AI" })

    -- Stop all pending requests
    vim.keymap.set("n", "<leader>9s", function()
      _99.stop_all_requests()
    end, { desc = "99: Stop all requests" })

    -- View logs for debugging
    vim.keymap.set("n", "<leader>9l", function()
      _99.view_logs()
    end, { desc = "99: View logs" })
  end,
}
