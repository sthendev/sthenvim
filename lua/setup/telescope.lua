local M = {}

local telescope = require('telescope')
local builtin = require('telescope.builtin')

function M.setup()
    telescope.setup{
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

function M.project_files(opts)
    vim.fn.system('git rev-parse --is-inside-work-tree')
    if vim.v.shell_error == 0 then
        builtin.git_files(opts)
    else
        builtin.find_files(opts)
    end
end

return M
