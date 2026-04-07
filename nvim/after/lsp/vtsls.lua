local util = require("lspconfig.util")

return {
  root_dir = function(fname)
    local angular_root = util.root_pattern("angular.json")(fname)
    if angular_root then
      return nil
    end
    return util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git")(fname)
  end,
}
