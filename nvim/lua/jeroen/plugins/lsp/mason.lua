return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_enable = {
        exclude = { "tsgo" },
      },
      ensure_installed = {
        "tsgo",
        "html",
        "cssls",
        "tailwindcss",
        "lua_ls",
      },
    },
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        },
      },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "oxlint",
      },
    },
    dependencies = {
      "williamboman/mason.nvim",
    },
  },
}
