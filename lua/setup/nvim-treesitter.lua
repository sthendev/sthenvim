local M = {}

function M.setup()
    require('nvim-treesitter.configs').setup{
        highlight = {
            enable = true,
            disable = false,
            additional_vim_regex_highlighting = false
        },
        indent = {
            enable = false
        },
        ensure_installed = {
            'c',
            'cmake',
            'cpp',
            'lua',
            'query',
            'vim',
            'vimdoc',
        }
    }
end

return M
