local function try_lint_first_available()
  local lint = require("lint")
  local linters = lint.linters_by_ft[vim.bo.filetype]

  if not linters then
    return
  end

  for _, linter in ipairs(linters) do
    local linter_config = lint.linters[linter]
    local linter_cmd = linter_config and linter_config.cmd
    if type(linter_cmd) == "function" then
      linter_cmd = linter_cmd()
    end
    if linter_cmd and vim.fn.executable(linter_cmd) == 1 then
      lint.try_lint({ linter })
      return
    end
  end
end

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "<leader>l", try_lint_first_available, desc = "Trigger linting" },
  },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "oxlint", "eslint_d" },
      typescript = { "oxlint", "eslint_d" },
      javascriptreact = { "oxlint", "eslint_d" },
      typescriptreact = { "oxlint", "eslint_d" },
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("lint", { clear = true }),
      callback = try_lint_first_available,
    })
  end,
}
