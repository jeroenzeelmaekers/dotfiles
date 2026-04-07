return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua",
        "json",
        "javascript",
        "typescript",
        "java",
        "html",
        "css",
        "tsx",
        "angular",
        "gitcommit",
        "diff",
        "c_sharp",
        "markdown",
        "markdown_inline",
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })

    vim.treesitter.language.register("html", "htmlangular")

    local query = vim.treesitter.query
    local non_filetype_aliases = { ex = "elixir", pl = "perl", sh = "bash", uxn = "uxntal", ts = "typescript" }
    local function get_lang(alias)
      local match = vim.filetype.match({ filename = "a." .. alias })
      return match or non_filetype_aliases[alias] or alias
    end

    query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
      local node = match[pred[2]]
      if not node then
        return
      end
      local ok, text = pcall(vim.treesitter.get_node_text, node, bufnr)
      if not ok or not text then
        return
      end
      metadata["injection.language"] = get_lang(text:lower())
    end, { force = true, all = false })
  end,
}
