local config = require("sthenvim.config")

return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "master",
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "bash",
            "c",
            "cmake",
            "cpp",
            "dockerfile",
            "json",
            "lua",
            "python",
            "vim",
            "vimdoc",
            "query",
            "markdown",
            "markdown_inline",
        },
        auto_install = false,
        highlight = {
            enable = true,
            disable = function(_, buf)
                -- check if file size exceeds threshold
                local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                return ok and stats and stats.size > config.ts_file_size_threshold
            end
        }
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end
}
