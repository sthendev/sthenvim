local M = {}

local utils = require('utils')

function M.setup()
    require('gitsigns').setup{
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                utils.bind(mode, l, r, opts)
            end

            -- Navigation
            map('n', '<leader>gk', function()
              vim.schedule(function() gs.prev_hunk() end)
              return '<Ignore>'
            end, {expr=true})

            map('n', '<leader>gj', function()
              vim.schedule(function() gs.next_hunk() end)
              return '<Ignore>'
            end, {expr=true})

            -- Actions
            map('n', '<leader>gk', gs.prev_hunk)
            map('n', '<leader>gj', gs.next_hunk)
            -- map('n', '<leader>hs', gs.stage_hunk)
            -- map('n', '<leader>hr', gs.reset_hunk)
            -- map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end)
            -- map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end)
            -- map('n', '<leader>hS', gs.stage_buffer)
            -- map('n', '<leader>hu', gs.undo_stage_hunk)
            -- map('n', '<leader>hR', gs.reset_buffer)
            map('n', '<leader>gp', gs.preview_hunk)
            -- map('n', '<leader>hb', function() gs.blame_line{full=true} end)
            -- map('n', '<leader>tb', gs.toggle_current_line_blame)
            map('n', '<leader>gd', gs.diffthis)
            -- map('n', '<leader>hD', function() gs.diffthis('~') end)
            -- map('n', '<leader>td', gs.toggle_deleted)

            -- Text object
            -- map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
    }
end

return M
