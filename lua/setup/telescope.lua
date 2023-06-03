local M = {}

function M.setup()
    require('telescope').setup{
        defaults = {
            mappings = {
                i = {
                    ['<C-j>'] = 'move_selection_next',
                    ['<C-k>'] = 'move_selection_previous',
                }
            }
        }
    }
end

return M
