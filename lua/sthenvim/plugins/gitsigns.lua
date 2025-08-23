local utils = require("sthenvim.utils")

return {
    "lewis6991/gitsigns.nvim",
    version = "1.*",
    opts = {
        on_attach = function(bufnr)
            local gitsigns = require("gitsigns")

            local map = function(keys, func, desc)
                vim.keymap.set("n", keys, func, { desc = desc, buffer = bufnr})
            end

            local nav_hunk_prev = function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gitsigns.nav_hunk("prev")
                end
            end

            local nav_hunk_next = function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gitsigns.nav_hunk("next")
                end
            end

            local blame_line_full = function() gitsigns.blame_line({ full = true }) end

            utils.fn_repeat(map, {
                { "[g",          nav_hunk_prev,                     "Previous [G]it hunk" },
                { "]g",          nav_hunk_next,                     "Next [G]it hunk" },
                { "<leader>gs",  gitsigns.stage_hunk,               "[G]it [S]tage hunk" },
                { "<leader>gr",  gitsigns.reset_hunk,               "[G]it [R]eset hunk" },
                { "<leader>gS",  gitsigns.stage_buffer,             "[G]it [S]tage buffer" },
                { "<leader>gR",  gitsigns.reset_buffer,             "[G]it [R]eset buffer" },
                { "<leader>gp",  gitsigns.preview_hunk,             "[G]it [P]review hunk" },
                { "<leader>gi",  gitsigns.preview_hunk_inline,      "[G]it preview hunk [I]nline" },
                { "<leader>gb",  blame_line_full,                   "[G]it [B]lame line" },
                { "<leader>gB",  gitsigns.blame,                    "[G]it [B]lame buffer" },
                { "<leader>tb", gitsigns.toggle_current_line_blame, "[T]oggle [B]lame line" },
                { "<leader>tw", gitsigns.toggle_word_diff,          "[T]oggle [W]ord diff" },
            })
        end
    }
}
