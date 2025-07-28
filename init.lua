--[[========================================================================]]--
--[[   ███████╗████████╗██╗  ██╗███████╗███╗   ██╗██╗   ██╗██╗███╗   ███╗   ]]--
--[[   ██╔════╝╚══██╔══╝██║  ██║██╔════╝████╗  ██║██║   ██║██║████╗ ████║   ]]--
--[[   ███████╗   ██║   ███████║█████╗  ██╔██╗ ██║██║   ██║██║██╔████╔██║   ]]--
--[[   ╚════██║   ██║   ██╔══██║██╔══╝  ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║   ]]--
--[[   ███████║   ██║   ██║  ██║███████╗██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║   ]]--
--[[   ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝   ]]--
--[[================================ CONFIG ================================]]--

local config = {
    nerd_font_enabled = true,
    trim_whitespace_on_write = true,
}

--[[=========================== HELPER FUNCTIONS ===========================]]--

-- set many keys on a table in one shot
local function tbl_set_keys(t, d)
    for k, v in pairs(d) do
        t[k] = v
    end
end

-- set key mapping
local function fn_repeat(f, v)
    for _, a in ipairs(v) do
        f(unpack(a))
    end
end


--[[=============================== SETTINGS ===============================]]--

tbl_set_keys(vim.g, {
    mapleader = " ",
    maplocalleader = "\\",
})

tbl_set_keys(vim.opt, {
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
    colorcolumn = { 80 },
    inccommand = "split",
    scrolloff = 3,
    confirm = true,
    showmode = false,
})

--[[================================= LAZY =================================]]--

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
      "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

{ -- colorscheme:
    "embark-theme/vim",
    name = "embark",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd([[ colorscheme embark ]])
    end,
},

{ -- tmux integration:
    "christoomey/vim-tmux-navigator",
    cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
        "TmuxNavigatorProcessList",
    },
    keys = {
        { "<C-h>", "<CMD><C-U>TmuxNavigateLeft<CR>" },
        { "<C-j>", "<CMD><C-U>TmuxNavigateDown<CR>" },
        { "<C-k>", "<CMD><C-U>TmuxNavigateUp<CR>" },
        { "<C-l>", "<CMD><C-U>TmuxNavigateRight<CR>" },
        { "<C-\\>", "<CMD><C-U>TmuxNavigatePrevious<CR>" },
    },
},

{ -- commenting shortcuts:
    "numToStr/Comment.nvim",
    opts = {
        toggler = {
            line = "<C-_>",
            block = "<NOP>",
        },
        opleader = {
            line = "<C-_>",
            block = "<NOP>",
        },
        mappings = {
            basic = true,
            extra = false,
        },
    }
},

{ -- detect indentation:
    "nmac427/guess-indent.nvim",
    opts = {}
},

{ -- auto brackets and more:
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}
},

{ -- navigation and more:
    "nvim-telescope/telescope.nvim",
    branch = "0.1.*",
    dependencies =  {
        "nvim-lua/plenary.nvim",
        { -- live grep options
            "nvim-telescope/telescope-live-grep-args.nvim",
            version="1.*",
        }
    },
    config = function()
        local telescope = require("telescope")
        local telescope_actions = require("telescope.actions")
        local telescope_lga_actions = require("telescope-live-grep-args.actions")

        local function send_to_quickfix(promptbufnr)
            telescope_actions.smart_send_to_qflist(promptbufnr)
            vim.cmd([[ copen ]])
        end

        telescope.setup({
            defaults = {
                layout_strategy = "flex",
                layout_config = {
                    flex = {
                        flip_columns = 200,
                    }
                },
                mappings = {
                    n = {
                        ["<C-q>"] = send_to_quickfix,
                    },
                    i = {
                        ["<C-j>"] = "move_selection_next",
                        ["<C-k>"] = "move_selection_previous",
                        ["<C-q>"] = send_to_quickfix,
                    },
                }
            },
            extensions = {
                live_grep_args = {
                    auto_quoting = true,
                    mappings = {
                        i = {
                            ["<C-k>"] = telescope_lga_actions.quote_prompt(),
                            ["<C-i>"] = telescope_lga_actions.quote_prompt({ postfix = " --iglob " }),
                            ["<C-space>"] = telescope_lga_actions.to_fuzzy_refine,
                        }
                    },
                }
            }
        })

        telescope.load_extension("live_grep_args")
    end
},

{ -- treesitter integration
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
            "editorconfig",
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
                local max_file_size = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size < max_file_size then
                    return false
                end
                return true
            end
        }
    }
},

{ -- treesitter context lines
    "nvim-treesitter/nvim-treesitter-context",
    opts = {}
},

{ -- lua neovim lsp configuration
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
        library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" }},
        }
    }
},

{ -- main lsp configuration
    "mason-org/mason-lspconfig.nvim",
    version = "2.*",
    dependencies = {
        {
            "mason-org/mason.nvim",
            version = "2.*",
            opts = {}
        },
        {
            "neovim/nvim-lspconfig",
            version = "2.*"
        },
        {
            "j-hui/fidget.nvim",
            opts = {}
        }
    },
    opts = {
        ensure_installed = {
            "clangd",
            "cmake",
            "lua_ls",
            "pyright",
        }
    }
},

{ -- auto completion and more
    "saghen/blink.cmp",
    version = "1.*",
    opts = {
        keymap = {
            preset = "super-tab"
        },
        sources = {
            default = { "lsp", "path", "buffer" },
        },
        signature = {
            enabled = true
        }
    }
},

{ --  status line
    "nvim-lualine/lualine.nvim",
    dependencies = {
        {
            "nvim-tree/nvim-web-devicons",
            opts = {}
        },
    },
    opts = {
        options  ={
            component_separators = config.nerd_font_enabled and {
                left = '', right = ''
            } or '',
            section_separators = config.nerd_font_enabled and {
                left = '', right = ''
            } or '',
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
},

{ -- terminal
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
        shell = "bash -l",
        direction = "float",
    }
},

{ -- git integration
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
    }
},

{ -- git gutter and more
    "lewis6991/gitsigns.nvim",
    version = "1.*",
    opts = {
        on_attach = function(bufnr)
            local gitsigns = require("gitsigns")

            local map = function(keys, func, desc)
                vim.keymap.set("n", keys, func, { desc = desc, buffer = bufnr})
            end

            local nav_hunk_prev = function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gitsigns.nav_hunk("prev")
                end
            end

            local nav_hunk_next = function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gitsigns.nav_hunk("next")
                end
            end

            local blame_line_full = function() gitsigns.blame_line({ full = true }) end

            fn_repeat(map, {
                { "[g",          nav_hunk_prev,                     "Previous [G]it hunk" },
                { "]g",          nav_hunk_next,                     "Next [G]it hunk" },
                { "<leader>gs",  gitsigns.stage_hunk,               "[G]it [S]tage hunk" },
                { "<leader>gr",  gitsigns.reset_hunk,               "[G]it [R]eset hunk" },
                { "<leader>gS",  gitsigns.stage_buffer,             "[G]it [S]tage buffer" },
                { "<leader>gR",  gitsigns.reset_buffer,             "[G]it [R]eset buffer" },
                { "<leader>gp",  gitsigns.preview_hunk,             "[G]it [P]review hunk" },
                { "<leader>gi",  gitsigns.preview_hunk_inline,      "[G]it preview hunk [I]nline" },
                { "<leader>gb",  blame_line_full,                   "[G]it [B]lame line" },
                { "<leader>gB",  gitsigns.blame,                    "[G]it [B]lame buffer" },
                { "<leader>tb", gitsigns.toggle_current_line_blame, "[T]oggle [B]lame line" },
                { "<leader>tw", gitsigns.toggle_word_diff,          "[T]oggle [W]ord diff" },
            })
        end
    }
},

{ -- file explorer and more
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = {
        {
            "nvim-tree/nvim-web-devicons",
            opts = {}
        },
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
    }
},

})

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
    end

    return function()
        picker(opts)
    end
end
local neogit = require("neogit")

fn_repeat(vim.keymap.set, {
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

    -- telescope:
    { "n", "<leader>ff", telescope("find_files"),       { desc = "[F]ind [F]iles" }},
    { "n", "<leader>fg", telescope("live_grep_args"),   { desc = "[F]ind by [G]rep" }},
    { "n", "<leader>fw", telescope("grep_string"),      { desc = "[F]ind current [W]ord" }},
    { "n", "<leader>fb", telescope("buffers"),          { desc = "[F]ind [B]uffers" }},
    { "n", "<leader>fk", telescope("keymaps"),          { desc = "[F]ind [K]eymaps" }},
    { "n", "<leader>fd", telescope("diagnostics"),      { desc = "[F]ind [D]iagnostics" }},
    { "n", "<leader>fl", telescope("resume"),           { desc = "[F]ind [L]ast search" }},
    { "n", "<leader>fr", telescope("oldfiles"),         { desc = "[F]ind [R]ecent" }},
    { "n", "<leader>fh", telescope("help_tags"),        { desc = "[F]ind [H]elp" }},

    -- diagnostics:
    { "n", "<leader>do", vim.diagnostic.open_float, { desc = "[D]iagnostic [O]pen"}},

    -- terminal:
    { "n", "<C-w><C-w>", "<CMD>ToggleTerm<CR>",              { desc = "Open terminal" }},
    { "t", "<C-w><C-w>", "<C-\\><C-n>:ToggleTerm<CR>",   { desc = "Close terminal" }},
    { "t", "<Esc><Esc>", "<C-\\><C-n>",                  { desc = "Escape terminal mode" }},

    -- windows:
    { "n", "<C-w><C-h>", "<CMD>vertical resize -5<CR>",      { desc = "Vertical window resize up" }},
    { "n", "<C-w><C-l>", "<CMD>vertical resize +5<CR>",      { desc = "Vertical window resize down" }},
    { "n", "<C-w><C-j>", "<CMD>resize -5<CR>",               { desc = "Horizontal window resize left" }},
    { "n", "<C-w><C-k>", "<CMD>resize +5<CR>",               { desc = "Horizontal window resize right" }},

    -- git:
    { "n", "<leader>gg", neogit.open,    { desc = "[G]it [S]tatus" }},

    -- file explorer:
    { "n", "-", "<CMD>Oil<CR>", { desc = "Open Parent Directory" }},

    -- disable defaults:
    { "i", "<C-j>", "<NOP>"},
    { "i", "<C-k>", "<NOP>"},
})

--[[=============================== COMMANDS ===============================]]--

fn_repeat(vim.api.nvim_create_user_command, {
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

fn_repeat(create_autocommand, {
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

                fn_repeat(map, {
                    { "gd", vim.lsp.buf.definition,      "[G]o [D]efinition" },
                    { "gD", vim.lsp.buf.declaration,     "[G]o [D]eclaration" },
                    { "gh", vim.lsp.buf.hover,           "[G]o [H]over" },
                    { "gi", vim.lsp.buf.implementation,  "[G]o [I]mplementation" },
                    { "gr", vim.lsp.buf.references,      "[G]o [R]eferences" },
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
    }
})

--[[========================================================================]]--
