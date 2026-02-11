local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.linebreak = true

opt.wrap = false
opt.colorcolumn = "80"

opt.smartcase = true
opt.ignorecase = true

opt.cursorline = true

opt.signcolumn = "yes"

opt.swapfile = false

opt.hlsearch = false
opt.incsearch = true

opt.scrolloff = 8

opt.fillchars = { eob = " " }

-- Auto-reload files changed outside of neovim
opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})
