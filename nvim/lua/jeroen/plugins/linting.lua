return {
  "mfussenegger/nvim-lint",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "oxlint", "eslint" },
      typescript = { "oxlint", "eslint" },
      javascriptreact = { "oxlint", "eslint" },
      typescriptreact = { "oxlint", "eslint" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    --- Try linters in order, stop after first available one is found
    local function try_lint_first_available()
      local ft = vim.bo.filetype
      local linters = lint.linters_by_ft[ft]

      if not linters then
        return
      end

      for _, linter in ipairs(linters) do
        local linter_cmd = lint.linters[linter] and lint.linters[linter].cmd
        if linter_cmd and vim.fn.executable(linter_cmd) == 1 then
          lint.try_lint({ linter })
          return
        end
      end
    end

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        try_lint_first_available()
      end,
    })

    vim.keymap.set("n", "<leader>l", function()
      try_lint_first_available()
    end, { desc = "Trigger linting for current file" })
  end,
}
