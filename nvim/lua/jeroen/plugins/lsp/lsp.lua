return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "LspInfo", "LspStart", "LspStop", "LspRestart" },
  dependencies = {
    "saghen/blink.cmp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    vim.lsp.config("*", {
      capabilities = capabilities,
      on_attach = function(client)
        -- Keep opened buffers visually consistent with Snacks file previews.
        -- Previews use Treesitter highlighting, while semantic tokens add a
        -- second layer of highlights once an LSP client attaches.
        client.server_capabilities.semanticTokensProvider = nil
      end,
    })

    vim.lsp.config("tsc", {
      single_file_support = false,
    })

    vim.lsp.enable("tsc")
  end,
}
