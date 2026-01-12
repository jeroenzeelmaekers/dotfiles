return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua",
        "json",
        "javascript",
        "typescript",
        "html",
        "css",
        "tsx",
        "angular",
        "gitcommit",
        "diff",
        "c_sharp",
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })

    vim.treesitter.language.register("typescript", "javascript")
    vim.treesitter.language.register("angular", "htmlangular")
  end,
}
