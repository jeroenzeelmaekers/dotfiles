return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  config = function()
    local parsers = {
      "lua",
      "json",
      "javascript",
      "typescript",
      "html",
      "css",
      "tsx",
      "angular",
      "gitcommit",
      "diff",
      "markdown",
      "markdown_inline",
    }

    if vim.fn.executable("curl") == 1 then
      table.insert(parsers, 1, "vim")
    end

    require("nvim-treesitter").setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    require("nvim-treesitter").install(parsers)

    vim.treesitter.language.register("html", "htmlangular")

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        if vim.bo[args.buf].filetype == "vim" then
          return
        end

        pcall(vim.treesitter.start, args.buf)
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
