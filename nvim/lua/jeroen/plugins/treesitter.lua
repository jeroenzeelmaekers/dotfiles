return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
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

    vim.treesitter.language.register("typescript", "javascript")
  end,
}
