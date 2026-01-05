return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup({
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "lua",
        "json",
        "javascript",
        "typescript",
        "html",
        "css",
        "tsx",
      },
      sync_install = false,
      auto_install = true,
    })
  end,
}
