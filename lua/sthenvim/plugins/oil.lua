local config = require("sthenvim.config")

return {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        columns = config.nerd_font_enabled and { "icon" } or {},
        keymaps = {
            ["<leader>o?"] = { "actions.show_help", mode = "n" },
            ["<CR>"] = "actions.select",
            ["<leader>ov"] = { "actions.select", opts = { vertical = true } },
            ["<leader>os"] = { "actions.select", opts = { horizontal = true } },
            ["<leader>ot"] = { "actions.select", opts = { tab = true } },
            ["<leader>op"] = "actions.preview",
            ["_"] = { "actions.close", mode = "n" },
            ["<leader>or"] = "actions.refresh",
            ["-"] = { "actions.parent", mode = "n" },
            ["~"] = { "actions.open_cwd", mode = "n" },
            ["<leader>cs"] = { "actions.change_sort", mode = "n" },
            ["<leader>ox"] = "actions.open_external",
            ["<leader>o."] = { "actions.toggle_hidden", mode = "n" },
            ["<leader>o\\"] = { "actions.toggle_trash", mode = "n" },
        },
        use_default_keymaps = false,
        view_options = {
            show_hidden = true,
        }
    }
}
