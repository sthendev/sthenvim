local M = {}

function M.setup()
    require('lsp-status').register_progress()
end

return M
