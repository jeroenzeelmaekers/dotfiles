return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    vim.lsp.config("vtsls", {
      root_dir = function(bufnr, on_dir)
        local root = vim.fs.root(bufnr, {
          "angular.json",
          "tsconfig.json",
          "jsconfig.json",
          "package-lock.json",
          "yarn.lock",
          "pnpm-lock.yaml",
          "bun.lockb",
          "bun.lock",
          "package.json",
          ".git",
        })
        on_dir(root or vim.fn.getcwd())
      end,
      single_file_support = false,
    })
  end,
}
