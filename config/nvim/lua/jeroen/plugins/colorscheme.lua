return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,
  config = function()
    require("rose-pine").setup({
      variant = "auto",
      dark_variant = "main",
    })

    local function sync_transparent_hl()
      local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
      local nontext = vim.api.nvim_get_hl(0, { name = "NonText", link = false })
      local fg = normal.fg and string.format("#%06x", normal.fg) or "NONE"
      local border_fg = nontext.fg and string.format("#%06x", nontext.fg) or fg

      for _, group in ipairs({
        "Normal",
        "NormalNC",
        "SignColumn",
        "EndOfBuffer",
        "FoldColumn",
        "LineNr",
        "CursorLineNr",
        "StatusLine",
        "StatusLineNC",
      }) do
        local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
        hl.bg = "NONE"
        vim.api.nvim_set_hl(0, group, hl)
      end

      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", fg = fg })
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE", fg = border_fg })
    end

    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = sync_transparent_hl,
    })

    vim.cmd.colorscheme("rose-pine")
  end,
}
