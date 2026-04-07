return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<c-\\>", "<cmd>ToggleTerm<cr>", mode = "n", desc = "Toggle terminal" },
    { "<c-\\>", [[<C-\><C-n><cmd>ToggleTerm<cr>]], mode = "t", desc = "Toggle terminal" },
  },
  opts = {
    shade_terminals = true,
    shading_factor = 2,
    direction = "float",
  },
}
