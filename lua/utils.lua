local M = {}

function M.prequire(module)
    return pcall(require, module)
end

return M
