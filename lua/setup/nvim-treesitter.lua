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
        }
    }
end

return M
