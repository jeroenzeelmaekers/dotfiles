return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find files",
    },
    {
      "<leader>fs",
      function()
        Snacks.picker.grep()
      end,
      desc = "Live grep",
    },
    {
      "<leader>ds",
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = "Document symbols",
    },
    {
      "<leader>lg",
      function()
        Snacks.lazygit.open()
      end,
      desc = "Document symbols",
    },
  },
  ---@type snacks.Config
  opts = {
    picker = {
      ui_select = true,
      sources = {
        files = {
          exclude = { "node_modules", "Pods", "android", "vendor", "target", ".dist" },
        },
        grep = {
          exclude = { "node_modules", "Pods", "android", "vendor", "target", ".dist" },
        },
      },
    },
    input = { enabled = true },
    lazygit = { enabled = true },
    image = { enabled = true },
    statuscolumn = {
      enabled = true,
      left = { "mark", "sign", "git" },
      right = {},
      git = {
        patterns = { "GitSign" },
      },
    },
  },
}
