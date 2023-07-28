local M = {}

local settings = require('settings')

function M.setup()
    settings.set_global('floaterm_width', 0.8)
    settings.set_global('floaterm_height', 0.8)
    settings.set_global('floaterm_autoclose', 2)
end

return M
