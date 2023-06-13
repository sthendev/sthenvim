local M = {}

function M.prequire(module)
    return pcall(require, module)
end

function M.bind(mode, key, fn, args)
    vim.keymap.set(mode, key, fn, args)
end

function M.file_exists(name)
    local f = io.open(name, 'r')
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end


return M
