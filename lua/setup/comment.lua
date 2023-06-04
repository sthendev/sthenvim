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
        },
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
    }
end

return M
