local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
local angularls_path = mason_packages .. "/angular-language-server"
local vtsls_path = mason_packages .. "/vtsls"

local cmd = {
  "ngserver",
  "--stdio",
  "--tsProbeLocations",
  table.concat({ vtsls_path, angularls_path }, ","),
  "--ngProbeLocations",
  table.concat({ angularls_path }, ","),
}

return {
  cmd = cmd,
  on_new_config = function(new_config)
    new_config.cmd = cmd
  end,
  filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
  root_dir = function(fname)
    local util = require("lspconfig.util")
    return util.root_pattern("angular.json")(fname)
  end,
}
