return {
    "nvim-telescope/telescope.nvim",
    version = "0.1.*",
    dependencies =  {
        "nvim-lua/plenary.nvim",
        { -- live grep options
            "nvim-telescope/telescope-live-grep-args.nvim",
            version="1.*",
        }
    },
    config = function()
        local telescope = require("telescope")
        local telescope_actions = require("telescope.actions")
        local telescope_lga_actions = require("telescope-live-grep-args.actions")

        local function send_to_quickfix(promptbufnr)
            telescope_actions.smart_send_to_qflist(promptbufnr)
            vim.cmd([[ copen ]])
        end

        telescope.setup({
            defaults = {
                layout_strategy = "flex",
                layout_config = {
                    flex = {
                        flip_columns = 200,
                    }
                },
                mappings = {
                    n = {
                        ["<C-q>"] = send_to_quickfix,
                    },
                    i = {
                        ["<C-j>"] = "move_selection_next",
                        ["<C-k>"] = "move_selection_previous",
                        ["<C-q>"] = send_to_quickfix,
                    },
                }
            },
            extensions = {
                live_grep_args = {
                    auto_quoting = true,
                    mappings = {
                        i = {
                            ["<C-s>"] = telescope_lga_actions.quote_prompt(),
                            ["<C-f>"] = telescope_lga_actions.quote_prompt({ postfix = " --iglob " }),
                            ["<C-SPACE>"] = telescope_lga_actions.to_fuzzy_refine,
                        }
                    },
                }
            }
        })

        telescope.load_extension("live_grep_args")
    end
}
