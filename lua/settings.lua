local M = {
    options = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        termguicolors = true,
        number = true,
        relativenumber = true
    },
    globals = {
        mapleader = " "
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
