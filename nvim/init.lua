-- Disable netrw early (before plugins load)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("jeroen.core")
require("jeroen.lazy")
require("jeroen.lsp")

