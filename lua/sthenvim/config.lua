local M = {}

M.defaults = {
  tabstop = 4,
  shiftwidth= 4
}

-- this is a comment
M.init = function()
  for k, v in pairs(M.defaults) do
    vim.opt[k] = v
  end
end

M.init()

return M
