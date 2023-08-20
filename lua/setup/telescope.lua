local M = {}

local telescope_actions = require('telescope.actions')

local function send_to_quickfix(promptbufnr)
    telescope_actions.smart_send_to_qflist(promptbufnr)
    vim.cmd([[botright copen]])
end

function M.setup()
    require('telescope').setup{
        defaults = {
            layout_strategy = 'flex',
            layout_config = {
                flex = {
                    flip_columns = 200
                }
            },
            mappings = {
                n = {
                    ['<C-q>'] = send_to_quickfix,
                },
                i = {
                    ['<C-j>'] = 'move_selection_next',
                    ['<C-k>'] = 'move_selection_previous',
                    ['<C-q>'] = send_to_quickfix,
                }
            }
        }
    }
end

return M
