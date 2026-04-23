return {
  "nvim-telescope/telescope.nvim",
  branch = "master",
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    {
      "nvim-tree/nvim-web-devicons",
    },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    telescope.setup({
      defaults = {
        file_ignore_patterns = { "node_modules", "Pods", "android", "vendor", "target", ".dist" },
        path_display = { "truncate" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
          },
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
  end,
}
