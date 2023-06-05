local M = {}

function M.setup()
    require('git-conflict').setup{
        default_mappings = false,
        disable_diagnostics = true,
    }
end

return M
