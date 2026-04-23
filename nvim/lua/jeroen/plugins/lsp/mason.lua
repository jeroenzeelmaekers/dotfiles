return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "vtsls",
        "html",
        "cssls",
        "tailwindcss",
        "lua_ls",
        "emmet_ls",
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
        "prettier",
        "eslint_d",
        "oxlint",
      },
    },
    dependencies = {
      "williamboman/mason.nvim",
    },
  },
}
