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
      javascript = { "oxfmt", "prettier", "biome", stop_after_first = true },
      typescript = { "oxfmt", "prettier", "biome", stop_after_first = true },
      javascriptreact = { "oxfmt", "prettier", "biome", stop_after_first = true },
      typescriptreact = { "oxfmt", "prettier", "biome", stop_after_first = true },
      json = { "oxfmt", "prettier", "biome", stop_after_first = true },
      css = { "oxfmt", "prettier", "biome", stop_after_first = true },
      html = { "oxfmt", "prettier", "biome", stop_after_first = true },
      yaml = { "prettier" },
      java = { "google-java-format" },
      lua = { "stylua" },
      cs = { "csharpier" },
      rust = { "rustfmt" },
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
      biome = {
        condition = function(_, ctx)
          return vim.fs.find({ "biome.json", "biome.jsonc" }, {
            path = ctx.filename,
            upward = true,
            stop = vim.uv.os_homedir(),
          })[1] ~= nil
        end,
      },
      csharpier = {
        prepend_args = { "--print-width", "120" },
      },
    },
    format_on_save = {
      lsp_fallback = true,
      async = false,
      timeout_ms = 3000,
    },
  },
}
