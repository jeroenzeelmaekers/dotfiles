return {
  "savq/melange-nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local function sync_float_hl()
      local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
      local nontext = vim.api.nvim_get_hl(0, { name = "NonText", link = false })
      local bg = normal.bg and string.format("#%06x", normal.bg) or "NONE"
      local fg = normal.fg and string.format("#%06x", normal.fg) or "NONE"
      local border_fg = nontext.fg and string.format("#%06x", nontext.fg) or fg
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = bg, fg = fg })
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = bg, fg = border_fg })
    end

    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = sync_float_hl,
    })

    vim.cmd("colorscheme melange")
  end,
}
