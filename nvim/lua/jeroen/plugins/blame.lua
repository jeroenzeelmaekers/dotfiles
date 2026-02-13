return {
  {
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function()
      require("blame").setup({
        format_fn = function(line_porcelain, config, idx)
          local hash = string.sub(line_porcelain.hash, 0, 7)
          if hash == "0000000" then
            return { idx = idx, values = { { textValue = "Not committed", hl = "Comment" } }, format = "%s" }
          end

          local summary = line_porcelain.summary
          if #summary > config.max_summary_width then
            summary = string.sub(summary, 0, config.max_summary_width - 3) .. "..."
          end

          return {
            idx = idx,
            values = {
              { textValue = os.date(config.date_format, line_porcelain.committer_time), hl = "Comment" },
              { textValue = line_porcelain.author, hl = hash },
              { textValue = summary, hl = hash },
            },
            format = "%s  %s  %s",
          }
        end,
      })
    end,
  },
}
