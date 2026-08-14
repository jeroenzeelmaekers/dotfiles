return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_enable = {
        exclude = { "tsgo" },
      },
      ensure_installed = {
        -- mason-lspconfig still installs the Typescript server under the legacy tsgo name.
        "tsgo",
        "html",
        "cssls",
        "tailwindcss",
        "lua_ls",
      },
    },
    dependencies = {
      {
        "mason-org/mason.nvim",
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
      "mason-org/mason.nvim",
    },
  },
}
