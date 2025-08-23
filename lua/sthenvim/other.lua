local config = require("sthenvim.config")
local utils = require("sthenvim.utils")

--[[========================== DIAGNOSTICS CONFIG ==========================]]--

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

--[[============================= DEFINE SIGNS =============================]]--

if config.nerd_font_enabled then
    utils.fn_repeat(vim.fn.sign_define, {
        { "DapBreakpoint",          { text = '󰀩 '}},
        { "DapBreakpointRejected",  { text = '󰝧 '}},
        { "DapBreakpointCondition", { text = '󱄶 '}},
        { "DapLogPoint",            { text = '󰭺 '}},
        { "DapStopped",             { text = '→ '}},
    })
end

--[[========================== KEYBOARD SHORTCUTS ==========================]]--

local telescope = function(name)
    local builtin = require("telescope.builtin")
    local lga = require("telescope").extensions.live_grep_args
    local opts = { disable_devicons = not config.nerd_font_enabled }

    local picker = nil
    if name == "live_grep_args" then
        picker = lga.live_grep_args
    else
        picker = builtin[name]
        if name == "find_files" then
            opts = vim.tbl_extend("keep", opts, {
                find_command = {
                    "rg", "--files", "--hidden",
                    "--glob", "!**/.git/*",
                    "--glob", "!**/node_modules/*"
                }
	    })
        end
    end

    return function()
        picker(opts)
    end
end

local neogit = require("neogit")

utils.fn_repeat(vim.keymap.set, {
    -- remove highlights:
    { "n", "<ESC>", "<CMD>nohlsearch<CR>"},

    -- cut/copy/paste:
    { "n", "<leader>yy", '"+yy', { desc = "Copy to system clipboard" }},
    { "n", "<leader>dd", '"+dd', { desc = "Cut to system clipboard" }},
    { "n", "<leader>p", '"+p',   { desc = "Paste (after) from system clipboard" }},
    { "n", "<leader>P", '"+P',   { desc = "Paste (before) from system clipboard" }},
    { "v", "<leader>y", '"+y',   { desc = "Copy highlighted to system clipboard" }},
    { "v", "<leader>d", '"+d',   { desc = "Cut highlighted to system clipboad" }},
    { "v", "<leader>p", '"+p',   { desc = "Paste replacing highlighted from system clipboard" }},
    { "v", "<leader>P", '"+P',   { desc = "Paste replacing highlighted from system clipboard" }},

    -- commenting:
    { "n", "<C-_>", "<CMD>norm gcc<CR>", { desc = "Comment line" }},
    { "v", "<C-_>", "<CMD>norm gc<CR>",  { desc = "Comment block" }},

    -- telescope:
    { "n", "<leader>ff", telescope("find_files"),     { desc = "[F]ind [F]iles" }},
    { "n", "<leader>fg", telescope("live_grep_args"), { desc = "[F]ind by [G]rep" }},
    { "n", "<leader>fw", telescope("grep_string"),    { desc = "[F]ind current [W]ord" }},
    { "n", "<leader>fb", telescope("buffers"),        { desc = "[F]ind [B]uffers" }},
    { "n", "<leader>fk", telescope("keymaps"),        { desc = "[F]ind [K]eymaps" }},
    { "n", "<leader>fd", telescope("diagnostics"),    { desc = "[F]ind [D]iagnostics" }},
    { "n", "<leader>fl", telescope("resume"),         { desc = "[F]ind [L]ast search" }},
    { "n", "<leader>fr", telescope("oldfiles"),       { desc = "[F]ind [R]ecent" }},
    { "n", "<leader>fh", telescope("help_tags"),      { desc = "[F]ind [H]elp" }},

    -- diagnostics:
    { "n", "<leader>dh", vim.diagnostic.open_float, { desc = "[D]iagnostic [H]over"}},

    -- terminal:
    { "n", "<C-w><C-w>", "<CMD>ToggleTerm<CR>",        { desc = "Open terminal" }},
    { "t", "<C-w><C-w>", "<C-\\><C-n>:ToggleTerm<CR>", { desc = "Close terminal" }},
    { "t", "<Esc><Esc>", "<C-\\><C-n>",                { desc = "Escape terminal mode" }},

    -- windows:
    { "n", "<C-w><C-h>", "<CMD>vertical resize -5<CR>", { desc = "Vertical window resize up" }},
    { "n", "<C-w><C-l>", "<CMD>vertical resize +5<CR>", { desc = "Vertical window resize down" }},
    { "n", "<C-w><C-j>", "<CMD>resize -5<CR>",          { desc = "Horizontal window resize left" }},
    { "n", "<C-w><C-k>", "<CMD>resize +5<CR>",          { desc = "Horizontal window resize right" }},

    -- debugging:
    { "n", "<leader>dr", "<CMD>DapContinue<CR>",         { desc = "[D]ebugger [R]un" }},
    { "n", "<leader>dt", "<CMD>DapTerminate<CR>",        { desc = "[D]ebugger [T]erminate" }},
    { "n", "<leader>dp", "<CMD>DapPause<CR>",            { desc = "[D]ebugger [P]ause" }},
    { "n", "<leader>db", "<CMD>DapToggleBreakpoint<CR>", { desc = "[D]ebugger toggle [B]reakpoint" }},
    { "n", "<leader>dc", "<CMD>DapClearBreakpoints<CR>", { desc = "[D]ebugger [C]lear breakpoints" }},
    { "n", "<leader>ds", "<CMD>DapStepOver<CR>",         { desc = "[D]ebugger [S]tep over" }},
    { "n", "<leader>di", "<CMD>DapStepInto<CR>",         { desc = "[D]ebugger step [I]nto" }},
    { "n", "<leader>do", "<CMD>DapStepOut<CR>",          { desc = "[D]ebugger step [O]ut" }},

    -- git:
    { "n", "<leader>gg", neogit.open,                          { desc = "Open Neogit" }},
    { "n", "<leader>co", "<Plug>(git-conflict-ours)",          { desc = "Git Conflict [C]hoose [O]urs" }},
    { "n", "<leader>ct", "<Plug>(git-conflict-theirs)",        { desc = "Git Conflict [C]hoose [T]heirs" }},
    { "n", "<leader>cb", "<Plug>(git-conflict-both)",          { desc = "Git Conflict [C]hoose [B]oth" }},
    { "n", "<leader>c0", "<Plug>(git-conflict-none)",          { desc = "Git Conflict [C]hoose None" }},
    { "n", "[c",         "<Plug>(git-conflict-prev-conflict)", { desc = "Git Conflict Previous" }},
    { "n", "]c",         "<Plug>(git-conflict-next-conflict)", { desc = "Git Conflict Next" }},

    -- file explorer:
    { "n", "-", "<CMD>Oil<CR>", { desc = "Open Parent Directory" }},

    -- disable defaults:
    { "i", "<C-j>", "<NOP>"},
    { "i", "<C-k>", "<NOP>"},
})

--[[=============================== COMMANDS ===============================]]--

utils.fn_repeat(vim.api.nvim_create_user_command, {
    {
        "TrimWhitespace", "%s/\\s\\+$//e", {}
    },
})

--[[============================= AUTOCOMMANDS =============================]]--

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

--[[========================================================================]]--
