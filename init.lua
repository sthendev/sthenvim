--[[========================================================================]]--
--[[======================== STHENVIM CONFIGURATION ========================]]--
--[[========================================================================]]--

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

--[[================================ CONFIG ================================]]--

local config = {
    nerd_font_enabled = true,
}

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
    undofile = true,
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
        { "<C-h>", "<cmd><C-U>TmuxNavigateLeft<CR>" },
        { "<C-j>", "<cmd><C-U>TmuxNavigateDown<CR>" },
        { "<C-k>", "<cmd><C-U>TmuxNavigateUp<CR>" },
        { "<C-l>", "<cmd><C-U>TmuxNavigateRight<CR>" },
        { "<C-\\>", "<cmd><C-U>TmuxNavigatePrevious<CR>" },
    },
},

{ -- commenting shortcuts:
    "numToStr/Comment.nvim",
    opts = {
        toggler = {
            line = '<C-_>',
            block = '<nop>',
        },
        opleader = {
            line = '<C-_>',
            block = '<nop>',
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
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'diff', 'diagnostics'},
            lualine_c = {'filename'},
            lualine_x = {
                'encoding',
                'fileformat',
                'filetype'},
            lualine_y = {'progress'},
            lualine_z = {'location'}
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
    opts = {}
},

})

--[[========================== KEYBOARD SHORTCUTS ==========================]]--

local telescope_builtin = require("telescope.builtin")
local telescope_lga = require("telescope").extensions.live_grep_args
local neogit = require("neogit")

fn_repeat(vim.keymap.set, {
    -- remove highlights:
    {"n", "<Esc>", "<cmd>nohlsearch<CR>"},

    -- cut/copy/paste:
    {"n", "<leader>yy", '"+yy', { desc = "Copy to system clipboard" }},
    {"n", "<leader>dd", '"+dd', { desc = "Cut to system clipboard" }},
    {"n", "<leader>p", '"+p',   { desc = "Paste (after) from system clipboard" }},
    {"n", "<leader>P", '"+P',   { desc = "Paste (before) from system clipboard" }},
    {"v", "<leader>y", '"+y',   { desc = "Copy highlighted to system clipboard" }},
    {"v", "<leader>d", '"+d',   { desc = "Cut highlighted to system clipboad" }},
    {"v", "<leader>p", '"+p',   { desc = "Paste replacing highlighted from system clipboard" }},
    {"v", "<leader>P", '"+P',   { desc = "Paste replacing highlighted from system clipboard" }},

    -- telescope:
    {"n", "<leader>ff", telescope_builtin.find_files,   { desc = "[F]ind [F]iles" }},
    {"n", "<leader>fg", telescope_lga.live_grep_args,   { desc = "[F]ind by [G]rep" }},
    {"n", "<leader>fw", telescope_builtin.grep_string,  { desc = "[F]ind current [W]ord" }},
    {"n", "<leader>fb", telescope_builtin.buffers,      { desc = "[F]ind [B]uffers" }},
    {"n", "<leader>fk", telescope_builtin.keymaps,      { desc = "[F]ind [K]eymaps" }},
    {"n", "<leader>fd", telescope_builtin.diagnostics,  { desc = "[F]ind [D]iagnostics" }},
    {"n", "<leader>fl", telescope_builtin.resume,       { desc = "[F]ind [L]ast search" }},
    {"n", "<leader>fr", telescope_builtin.oldfiles,     { desc = "[F]ind [R]ecent" }},
    {"n", "<leader>fh", telescope_builtin.help_tags,    { desc = "[F]ind [H]elp" }},

    -- diagnostics:
    {"n", "<leader>do", vim.diagnostic.open_float, { desc = "[D]iagnostic [O]pen"}},

    -- terminal:
    {"n", "<C-w><C-w>", ":ToggleTerm<CR>",              { desc = "Open terminal" }},
    {"t", "<C-w><C-w>", "<C-\\><C-n>:ToggleTerm<CR>",   { desc = "Close terminal" }},
    {"t", "<Esc><Esc>", "<C-\\><C-n>",                  { desc = "Escape terminal mode" }},

    -- windows:
    {"n", "<C-w><C-h>", ":vertical resize -5<CR>",      { desc = "Vertical window resize up" }},
    {"n", "<C-w><C-l>", ":vertical resize +5<CR>",      { desc = "Vertical window resize down" }},
    {"n", "<C-w><C-j>", ":resize -5<CR>",               { desc = "Horizontal window resize left" }},
    {"n", "<C-w><C-k>", ":resize +5<CR>",               { desc = "Horizontal window resize right" }},

    -- git:
    {"n", "<leader>gg", neogit.open,    { desc = "[G]it [S]tatus" }},

    -- disable defaults:
    {"i", "<C-j>", "<nop>"},
    {"i", "<C-k>", "<nop>"},
})

--[[============================= AUTOCOMMANDS =============================]]--

fn_repeat(vim.api.nvim_create_autocmd, {
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
                    {"gd", vim.lsp.buf.definition,      "[G]o [D]efinition"},
                    {"gD", vim.lsp.buf.declaration,     "[G]o [D]eclaration"},
                    {"gh", vim.lsp.buf.hover,           "[G]o [H]over"},
                    {"gi", vim.lsp.buf.implementation,  "[G]o [I]mplementation"},
                    {"gr", vim.lsp.buf.references,      "[G]o [R]eferences"},
                })
            end,
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

--[[========================================================================]]--
