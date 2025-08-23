return {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
        "mason-org/mason.nvim",
    },
    opts = {
        ensure_installed = {
            "codelldb",
        },
        handlers = {}
    }
}
