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
        maplocalleader = ' ',
        pyindent_disable_parentheses_indenting = true,
        skip_ts_context_commentstring_module = true,
    },
    config = {
        trim_whitespace_on_write = true,
        ccls_initial_blacklist = {},
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
