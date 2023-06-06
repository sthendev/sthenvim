local M = {}

function M.prequire(module)
    return pcall(require, module)
end

function M.bind(mode, key, fn, args)
    vim.keymap.set(mode, key, fn, args)
end


return M
