return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      "<leader>mp",
      function()
        require("conform").format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 3000,
        })
      end,
      mode = { "n", "v" },
      desc = "Format file or selection",
    },
  },
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
    },
    formatters = {
      oxfmt = {
        condition = function(_, ctx)
          return vim.fs.find({ ".oxfmtrc.json", ".oxfmtrc.jsonc" }, {
            path = ctx.filename,
            upward = true,
            stop = vim.uv.os_homedir(),
          })[1] ~= nil
        end,
      },
    },
    format_on_save = {
      lsp_fallback = true,
      async = false,
      timeout_ms = 3000,
    },
  },
}
