return {
  "mikavilpas/yazi.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>e", "<cmd>Yazi<cr>", desc = "Open yazi at current file" },
    { "<leader>cw", "<cmd>Yazi cwd<cr>", desc = "Open yazi in cwd" },
    { "<leader>-", "<cmd>Yazi toggle<cr>", desc = "Resume last yazi session" },
  },
  ---@diagnostic disable-next-line: unused-local
  init = function(_)
    -- Hijack directory buffers before plugin loads (replaces netrw)
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("YaziDirHijack", { clear = true }),
      callback = function(args)
        if vim.fn.isdirectory(vim.api.nvim_buf_get_name(args.buf)) == 1 then
          require("yazi").setup({ open_for_directories = true })
          -- Remove this autocmd once yazi is loaded
          vim.api.nvim_del_augroup_by_name("YaziDirHijack")
          -- Re-trigger to open the directory
          vim.cmd.edit(vim.api.nvim_buf_get_name(args.buf))
        end
      end,
    })
  end,
  opts = {
    open_for_directories = true,
    keymaps = {
      show_help = "<f1>",
    },
  },
}
