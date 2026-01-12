return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    local lazy_status = require("lazy.status")

    require("lualine").setup({
      options = {
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { { "mode", separator = { left = "" } } },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
        lualine_z = {
          { "location", separator = { right = "" } },
        },
      },
    })
  end,
}
