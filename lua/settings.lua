local M = {
    options = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        termguicolors = true,
        number = true,
        relativenumber = true,
        ttimeoutlen = 0,
        nrformats = {'hex', 'alpha'},
        colorcolumn = {80},
    },
    globals = {
        mapleader = " "
    },
    config = {
        trim_whitespace_on_write = true
    }
}

for k, v in pairs(M.options) do
    vim.opt[k] = v
end

for k, v in pairs(M.globals) do
    vim.g[k] = v
end

vim.cmd('colorscheme embark')

return M
