local function config_in_project(files)
  for _, f in ipairs(files) do
    if vim.fn.filereadable(vim.fn.getcwd() .. "/" .. f) == 1 then
      return true
    end
  end
  return false
end

local function detect_formatter()
  if config_in_project({ "biome.json", "biome.jsonc" }) then
    return "biome"
  else
    return "prettier"
  end
end

vim.api.nvim_create_autocmd("BufReadPre", {
  pattern = { "*.js", "*.ts", "*.json" },
  callback = function()
    local fmt = detect_formatter()
    vim.b.local_formatter = fmt
  end,
})

return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        javascript = { detect_formatter() },
        typescript = { detect_formatter() },
        javascriptreact = { detect_formatter() },
        typescriptreact = { detect_formatter() },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
      },
      formatters = {},
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end)
  end,
}
