return {
  "mfussenegger/nvim-lint",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- ESLint is handled by eslint LSP, so we only add non-JS linters here
    -- Add other linters as needed, e.g.:
    -- lint.linters_by_ft = {
    --   python = { "pylint" },
    --   go = { "golangcilint" },
    -- }
    lint.linters_by_ft = {
      javascript = { "oxlint" },
      typescript = { "oxlint" },
      javascriptreact = { "oxlint" },
      typescriptreact = { "oxlint" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
