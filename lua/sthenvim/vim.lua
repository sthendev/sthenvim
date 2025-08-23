local config = require("sthenvim.config")
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

vim.diagnostic.config({
    severity_sort = true,
    signs = config.nerd_font_enabled and {
        text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
    } or {},
})

if config.nerd_font_enabled then
    utils.fn_repeat(vim.fn.sign_define, {
        { "DapBreakpoint",          { text = '󰀩 '}},
        { "DapBreakpointRejected",  { text = '󰝧 '}},
        { "DapBreakpointCondition", { text = '󱄶 '}},
        { "DapLogPoint",            { text = '󰭺 '}},
        { "DapStopped",             { text = '→ '}},
    })
end

utils.fn_repeat(vim.api.nvim_create_user_command, {
    {
        "TrimWhitespace", "%s/\\s\\+$//e", {}
    },
})

local function create_autocommand(name, opts, disabled)
    if not disabled == true then
        vim.api.nvim_create_autocmd(name, opts)
    end
end

utils.fn_repeat(create_autocommand, {
    { -- highlight text on yank
        "TextYankPost",
        {
            desc = "Highlight when copying text",
            group = vim.api.nvim_create_augroup("sthenvim-highlight-yank", {
                clear = true
            }),
            callback = function()
                vim.hl.on_yank({higroup = "Visual", timeout = 200})
            end,
        }
    },
    { -- bind lsp mappings on attach
        "LspAttach",
        {
            desc = "Bind LSP mappings",
            group = vim.api.nvim_create_augroup("sthenvim-lsp-attach", {
                clear = true
            }),
            callback = function(event)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { desc = desc, buffer = event.buffer})
                end

                local lsp = function(name)
                    return vim.lsp.buf[name]
                end

                utils.fn_repeat(map, {
                    { "gd", lsp("definition"),                      "[G]o [D]efinition" },
                    { "gD", lsp("declaration"),                     "[G]o [D]eclaration" },
                    { "gh", lsp("hover"),                           "[G]o [H]over" },
                    { "gi", lsp("implementation"),                  "[G]o [I]mplementation" },
                    { "gr", lsp("references"),                      "[G]o [R]eferences" },
                    { "gs", "<CMD>LspClangdSwitchSourceHeader<CR>", "[G]o [S]witch Source/Header" },
                })
            end,
        }
    },
    { -- trim trailing whitespace on write
        "BufWritePre",
        {
            pattern = "*",
            command = ":TrimWhitespace",
        },
        disabled = not config.trim_whitespace_on_write
    },
    { -- remove after next telescope release
        "User",
        {
            pattern = "TelescopeFindPre",
            callback = function()
                vim.opt_local.winborder = "none"
                vim.api.nvim_create_autocmd("WinLeave", {
                    once = true,
                    callback = function()
                        vim.opt_local.winborder = "rounded"
                    end
                })
            end
        }
    },
})



