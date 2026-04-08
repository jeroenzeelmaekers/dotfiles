vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✗",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.HINT] = "➜",
      [vim.diagnostic.severity.INFO] = "➜",
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(ev)
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
    end

    map("n", "gR", "<cmd>Telescope lsp_references<CR>", "Show LSP references")
    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    map("n", "gd", vim.lsp.buf.definition, "Show LSP definition")
    map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations")
    map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code actions")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Buffer diagnostics")
    map("n", "<leader>d", vim.diagnostic.open_float, "Line diagnostics")
    map("n", "[d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, "Prev diagnostic")
    map("n", "]d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, "Next diagnostic")
    map("n", "K", vim.lsp.buf.hover, "Hover documentation")
    map("n", "<leader>rs", ":LspRestart<CR>", "Restart LSP")
  end,
})
