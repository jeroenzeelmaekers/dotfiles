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
opt.smartindent = true
opt.linebreak = true

opt.wrap = false

opt.smartcase = true
opt.ignorecase = true

opt.cursorline = false

opt.signcolumn = "yes"

opt.swapfile = false

opt.hlsearch = false
opt.incsearch = true

opt.scrolloff = 8

opt.fillchars = { eob = " " }

opt.undofile = true

opt.termguicolors = true

opt.updatetime = 250

opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

-- Auto-reload files changed outside of neovim
opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = vim.api.nvim_create_augroup("AutoReload", { clear = true }),
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})
