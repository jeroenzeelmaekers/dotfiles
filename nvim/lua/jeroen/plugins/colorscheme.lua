return {
  "savq/melange-nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd("colorscheme melange")

    -- Make nvim-tree float window use the same background as Neovim
    local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
    vim.api.nvim_set_hl(0, "NvimTreeNormalFloat", { bg = normal_bg })
    vim.api.nvim_set_hl(0, "NvimTreeFloatBorder", { bg = normal_bg })
  end,
}
