local M = {}

function M.setup()
    require('Comment').setup{
        toggler = {
            line = '<C-_>',
            block = '<nop>',
        },
        opleader = {
            line = '<C-_>',
            block = '<nop>',
        },
        mappings = {
            basic = true,
            extra = false,
        }
    }
end

return M
