return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      javascript = { "oxfmt", "prettier", stop_after_first = true },
      typescript = { "oxfmt", "prettier", stop_after_first = true },
      javascriptreact = { "oxfmt", "prettier", stop_after_first = true },
      typescriptreact = { "oxfmt", "prettier", stop_after_first = true },
      json = { "oxfmt", "prettier", stop_after_first = true },
      css = { "oxfmt", "prettier", stop_after_first = true },
      html = { "oxfmt", "prettier", stop_after_first = true },
      yaml = { "prettier" },
      lua = { "stylua" },
      csharp = { "csharpier" },
    },
    format_on_save = {
      lsp_format = "fallback",
      async = false,
      timeout_ms = 3000,
    },
  },
}
