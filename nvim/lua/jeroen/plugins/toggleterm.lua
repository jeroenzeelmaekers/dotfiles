return {
  "akinsho/toggleterm.nvim",
  dependencies = { "christoomey/vim-tmux-navigator" },
  version = "*",
  config = function()
    require("toggleterm").setup({
      shade_terminals = true,
      shading_factor = 2,
      direction = "float",
    })

    vim.keymap.set("n", "<c-\\>", "<cmd>ToggleTerm<cr>")
    vim.keymap.set("t", "<c-\\>", [[<C-\><C-n><cmd>ToggleTerm<cr>]])
  end,
}
