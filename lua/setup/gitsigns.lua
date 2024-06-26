local M = {}

function M.setup()
    require('gitsigns').setup{
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Actions
            map('n', '<leader>gk', gs.prev_hunk)
            map('n', '<leader>gj', gs.next_hunk)
            -- map('n', '<leader>gs', gs.stage_hunk)
            map('n', '<leader>gr', gs.reset_hunk)
            -- map('v', '<leader>gs', function() gs.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end)
            -- map('v', '<leader>gr', function() gs.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end)
            -- map('n', '<leader>gS', gs.stage_buffer)
            -- map('n', '<leader>gu', gs.undo_stage_hunk)
            -- map('n', '<leader>gR', gs.reset_buffer)
            map('n', '<leader>gp', gs.preview_hunk)
            -- map('n', '<leader>gb', function() gs.blame_line{full=true} end)
            map('n', '<leader>gb', gs.toggle_current_line_blame)
            map('n', '<leader>gd', gs.diffthis)
            -- map('n', '<leader>hD', function() gs.diffthis('~') end)
            -- map('n', '<leader>td', gs.toggle_deleted)

            -- Text object
            -- map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
    }
end

return M
