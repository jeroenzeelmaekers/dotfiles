return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
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
    })

    telescope.load_extension("fzf")
  end,
}
