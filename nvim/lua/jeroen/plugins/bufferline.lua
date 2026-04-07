return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  keys = {
    { "<S-h>", "<cmd>tabprevious<CR>", desc = "Prev tab" },
    { "<S-l>", "<cmd>tabnext<CR>", desc = "Next tab" },
    { "<leader>tn", "<cmd>tabnew<CR>", desc = "New tab" },
    { "<leader>tx", "<cmd>tabclose<CR>", desc = "Close tab" },
    { "<leader>to", "<cmd>tabonly<CR>", desc = "Close other tabs" },
  },
  config = function()
    local bufferline = require("bufferline")
    bufferline.setup({
      options = {
        mode = "tabs",
        always_show_bufferline = false,
        style_preset = bufferline.style_preset.minimal,
        offsets = {},
      },
    })
  end,
}
