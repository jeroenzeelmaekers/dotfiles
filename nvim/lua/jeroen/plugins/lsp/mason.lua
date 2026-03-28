return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "ts_ls",
        "angularls",
        "html",
        "cssls",
        "tailwindcss",
        "lua_ls",
        "emmet_ls",
        "eslint",
        "jdtls",
        "omnisharp",
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
        "prettier",
        "biome",
        "stylua",
        "eslint_d",
        "csharpier",
        "google-java-format",
        "java-debug-adapter",
        "java-test",
        "oxlint",
      },
    },
    dependencies = {
      "williamboman/mason.nvim",
    },
  },
}
