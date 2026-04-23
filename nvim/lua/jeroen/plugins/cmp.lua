return {
  "saghen/blink.cmp",
  version = "1.*",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets",
    { "folke/lazydev.nvim", opts = {} },
    { "echasnovski/mini.icons", opts = {} },
    { "xzbdmw/colorful-menu.nvim", opts = {} },
  },
  opts = {
    keymap = {
      preset = "default",
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-Space>"] = { "show", "fallback" },
      ["<C-e>"] = { "cancel", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    completion = {
      list = {
        selection = { preselect = false, auto_insert = false },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      menu = {
        draw = {
          treesitter = { "lsp" },
          columns = { { "kind_icon" }, { "label", gap = 1 }, { "source_name" } },
          components = {
            kind_icon = {
              text = function(ctx)
                local icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return icon
              end,
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
            source_name = {
              text = function(ctx)
                local map = { LSP = "LSP", Snippets = "Snip", Buffer = "Buf", Path = "Path", LazyDev = "Dev" }
                return map[ctx.source_name] or ctx.source_name
              end,
              highlight = "BlinkCmpSource",
            },
          },
        },
      },
      ghost_text = { enabled = true },
    },

    signature = {
      enabled = true,
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer", "lazydev" },
      providers = {
        snippets = {},
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
        },
      },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },

    snippets = {
      preset = "default",
    },
  },
}
