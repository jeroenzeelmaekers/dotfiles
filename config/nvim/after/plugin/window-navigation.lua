-- Keep split navigation available in Neovim outside Rex.
if vim.env.REX_SESSION and vim.env.REX_SESSION ~= "" then
  return
end

for key, direction in pairs({ h = "h", j = "j", k = "k", l = "l" }) do
  vim.keymap.set("n", "<C-" .. key .. ">", "<C-w>" .. direction, {
    desc = "Navigate to " .. direction .. " Neovim window",
  })
end
