return {
    "mason-org/mason-lspconfig.nvim",
    version = "2.*",
    dependencies = {
        "mason-org/mason.nvim",
        "neovim/nvim-lspconfig",
        "j-hui/fidget.nvim",
    },
    opts = {
        ensure_installed = {
            "clangd",
            "cmake",
            "lua_ls",
            "pyright",
            "bashls"
        }
    }
}
