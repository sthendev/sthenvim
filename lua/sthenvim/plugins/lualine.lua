local config = require("sthenvim.config")

return {
    "nvim-lualine/lualine.nvim",
    "nvim-tree/nvim-web-devicons",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        options  ={
            component_separators = config.nerd_font_enabled and {
                left = '', right = ''
            } or '',
            section_separators = config.nerd_font_enabled and {
                left = '', right = ''
            } or '',
            disabled_filetypes = {
                "Avante",
                "AvanteSelectedFiles",
                "AvanteInput",
                "AvanteTodos",
            }
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "diff", "diagnostics" },
            lualine_c = {
                {"filename", path = 1}
            },
            lualine_x = config.nerd_font_enabled and {
                "encoding",
                "fileformat",
                "filetype",
            } or {},
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
    }
}
