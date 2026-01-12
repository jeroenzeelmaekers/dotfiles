return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier", "biome", stop_after_first = true },
        typescript = { "prettier", "biome", stop_after_first = true },
        javascriptreact = { "prettier", "biome", stop_after_first = true },
        typescriptreact = { "prettier", "biome", stop_after_first = true },
        json = { "prettier", "biome", stop_after_first = true },
        css = { "prettier", "biome", stop_after_first = true },
        html = { "prettier", "biome", stop_after_first = true },
        lua = { "stylua" },
      },
      formatters = {
				biome = {
					condition = function(_, ctx)
						return vim.fs.find({ "biome.json", "biome.jsonc" }, {
							path = ctx.filename,
							upward = true,
							stop = vim.uv.os_homedir(),
						})[1] ~= nil
					end,
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    }})

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or selection" })
  end,
}
