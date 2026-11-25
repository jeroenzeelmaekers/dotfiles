return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    local lazy_status = require("lazy.status")
    local lualine = require("lualine")

    local function lualine_theme()
      local theme = require("catppuccin.utils.lualine")()

      for _, sections in pairs(theme) do
        local mode_colors = sections.a
        if mode_colors and mode_colors.bg ~= "NONE" then
          mode_colors.fg = mode_colors.bg
        end

        for _, colors in pairs(sections) do
          colors.bg = "NONE"
        end

        local text_colors = sections.c or sections.b or sections.a or {}
        sections.x = vim.tbl_deep_extend("force", vim.deepcopy(text_colors), { bg = "NONE" })
        sections.y = vim.tbl_deep_extend("force", vim.deepcopy(text_colors), { bg = "NONE" })
        sections.z = vim.tbl_deep_extend("force", vim.deepcopy(text_colors), { bg = "NONE" })
      end

      return theme
    end

    local function pill(component, color)
      local item = vim.deepcopy(component)

      if color then
        item.color = vim.tbl_extend("force", item.color or {}, vim.deepcopy(color))
      end

      -- item.separator = { left = "", right = "" }
      item.padding = item.padding or { left = 1, right = 1 }
      return item
    end

    lualine.setup({
      options = {
        theme = lualine_theme,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        always_divide_middle = false,
      },
      sections = {
        lualine_a = { pill({ "mode" }) },
        lualine_b = { pill({ "branch", icon = "" }) },
        lualine_c = { pill({ "filename", path = 1 }) },
        lualine_x = {
          pill({ lazy_status.updates, cond = lazy_status.has_updates }),
          pill({ "encoding" }),
        },
        lualine_y = {
          pill({ "fileformat" }),
          pill({ "filetype" }),
        },
        lualine_z = { pill({ "location" }) },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { { "location" } },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = {
        "lazy",
        "man",
        "quickfix",
      },
    })
  end,
}
