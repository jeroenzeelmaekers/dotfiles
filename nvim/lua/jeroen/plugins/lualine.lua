return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    local lazy_status = require("lazy.status")
    local lualine = require("lualine")

    local function pill(component, color)
      local item = vim.deepcopy(component)

      if color then
        item.color = vim.tbl_extend("force", item.color or {}, vim.deepcopy(color))
      end

      item.separator = { left = "", right = "" }
      item.padding = item.padding or { left = 1, right = 1 }
      return item
    end

    local function setup_lualine()
      package.loaded["lualine.themes.melange"] = nil

      local melange = require("melange/palettes/" .. vim.opt.background:get())
      local theme = require("lualine.themes.melange")

      lualine.setup({
        options = {
          theme = theme,
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
          always_divide_middle = false,
        },
        sections = {
          lualine_a = { pill({ "mode" }) },
          lualine_b = {
            pill({ "branch", icon = "" }, {
              bg = theme.normal.c.bg,
              fg = theme.normal.b.fg,
            }),
          },
          lualine_c = { pill({ "filename", path = 1 }, theme.normal.c) },
          lualine_x = {
            pill({ lazy_status.updates, cond = lazy_status.has_updates }, theme.normal.c),
            pill({ "encoding" }, theme.normal.c),
          },
          lualine_y = {
            pill({ "fileformat" }, theme.normal.c),
            pill({ "filetype" }, theme.normal.c),
          },
          lualine_z = { pill({ "location" }, theme.normal.c) },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              "filename",
              path = 1,
              color = { fg = melange.a.com, bg = melange.a.float },
            },
          },
          lualine_x = {
            {
              "location",
              color = { fg = melange.a.com, bg = melange.a.float },
            },
          },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = {
          "lazy",
          "man",
          "quickfix",
        },
      })
    end

    setup_lualine()

    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = setup_lualine,
    })

    vim.api.nvim_create_autocmd("OptionSet", {
      pattern = "background",
      callback = setup_lualine,
    })
  end,
}
