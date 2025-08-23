local utils = require("sthenvim.utils")

utils.tbl_set_keys(vim.g, {
    mapleader = " ",
    maplocalleader = "\\",
})

utils.tbl_set_keys(vim.opt, {
    termguicolors = true,
    number = true,
    relativenumber = true,
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    breakindent = true,
    ignorecase = true,
    smartcase = true,
    signcolumn = "yes",
    updatetime = 250,
    timeoutlen = 300,
    splitright = true,
    splitbelow = true,
    list = true,
    listchars = { tab = "» ", trail = "·", nbsp = "␣" },
    colorcolumn = { 80, 120 },
    inccommand = "split",
    scrolloff = 3,
    confirm = true,
    showmode = false,
    winborder = "rounded",
})
