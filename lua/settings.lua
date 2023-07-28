local M = {
    options = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        termguicolors = true,
        number = true,
        relativenumber = true,
        nrformats = {'hex', 'alpha'},
        colorcolumn = {80},
    },
    globals = {
        mapleader = ' ',
        maplocalleader = ' '
    },
    config = {
        trim_whitespace_on_write = true
    }
}

function M.set_option(key, value)
    vim.opt[key] = value
end

function M.set_global(key, value)
    vim.g[key] = value
end

for k, v in pairs(M.options) do
    M.set_option(k, v)
end

for k, v in pairs(M.globals) do
    M.set_global(k, v)
end

return M
