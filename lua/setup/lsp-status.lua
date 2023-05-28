local M = {}

local lsp_status = require('lsp-status')

function M.setup()
    lsp_status.config{
        current_function = false,
        show_filename = false,
        diagnostics = false,
        status_symbol = ''
    }
    lsp_status.register_progress()
end

return M
