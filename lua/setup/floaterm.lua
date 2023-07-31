local M = {}

local settings = require('settings')

M.config = {
    width = 0.8,
    height = 0.8,
    autoclose = 2,
    giteditor = false
}

function M.setup()
    for k, v in pairs(M.config) do
        settings.set_global('floaterm_' .. k, v)
    end
end

return M
