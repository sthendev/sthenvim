return {
    "yetone/avante.nvim",
    version = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
        "zbirenbaum/copilot.lua",
    },
    build = "make",
    event = "VeryLazy",
    opts = {
        provider = "copilot",
        windows = {
            sidebar_header = {
                enabled = true,
                rounded = false,
            },
            edit = {
                border = "rounded"
            },
            ask = {
                border = "rounded"
            },
            spinner = {
                thinking = {" "}
            }
        },
        hints = {
            enabled = false
        },
    }
}
