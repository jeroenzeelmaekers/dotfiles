return {
  filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
  root_dir = function(fname)
    local util = require("lspconfig.util")
    -- Only start angularls if angular.json exists in the project root
    return util.root_pattern("angular.json")(fname)
  end,
}
