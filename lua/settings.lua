local M = {
    options = {
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        termguicolors = true,
        number = true,
        relativenumber = true,
        colorcolumn = {80},
    },
    globals = {
        mapleader = ' ',
        maplocalleader = ' ',
        pyindent_disable_parentheses_indenting = true,
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

function M.set_config(key, value)
    M.config[key] = value
end

function M.get_config(key, default)
    local v = M.config[key]
    if v == nil then
        return default
    end
    return v
end

for k, v in pairs(M.options) do
    M.set_option(k, v)
end

for k, v in pairs(M.globals) do
    M.set_global(k, v)
end

return M
