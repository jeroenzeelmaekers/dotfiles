return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = {
    indent = {
      char = "│",
      highlight = "IblIndent",
    },
    scope = {
      enabled = false,
    },
  },
  config = function(_, opts)
    local function set_ibl_hl()
      local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
      if bg then
        -- Slightly offset from background for subtle visibility
        local offset = vim.o.background == "dark" and 0x101010 or -0x101010
        vim.api.nvim_set_hl(0, "IblIndent", { fg = bg + offset })
      end
    end

    set_ibl_hl()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = set_ibl_hl })
    require("ibl").setup(opts)
  end,
}
