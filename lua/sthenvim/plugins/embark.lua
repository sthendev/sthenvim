return {
    "sthendev/embark.nvim",
    dir = "~/Projects/embark.nvim",
    name = "embark",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd([[ colorscheme embark ]])
    end,
}
