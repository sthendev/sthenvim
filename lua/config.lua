local M = {
  tabstop = 4,
  shiftwidth = 4,
  expandtab = true,
  termguicolors = true
}

for k, v in pairs(M) do
  vim.opt[k] = v
end

return M
