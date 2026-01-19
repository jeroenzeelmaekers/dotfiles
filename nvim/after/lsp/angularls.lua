return {
  filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
  root_dir = function(fname)
    local util = require("lspconfig.util")
    return util.root_pattern("angular.json")(fname)
  end,
}
