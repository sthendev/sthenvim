return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'tpope/vim-fugitive'

    use 'tpope/vim-sleuth'

    use {
        'windwp/nvim-autopairs',
        config = function() require('setup.nvim-autopairs').setup() end
    }

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'hrsh7th/cmp-cmdline'},
            {'hrsh7th/cmp-vsnip'},
            {'hrsh7th/cmp-nvim-lsp-signature-help'},
            {'hrsh7th/vim-vsnip'}
        },
        config = function() require('setup.nvim-cmp').setup() end
    }

    use {
        'nvim-lua/lsp-status.nvim',
        config = function() require('setup.lsp-status').setup() end
    }

    use {
        'neovim/nvim-lspconfig',
        config = function() require('setup.nvim-lspconfig').setup() end,
        requires = {
            {
                'j-hui/fidget.nvim',
                tag = 'legacy',
                config = function() require('setup.fidget').setup() end
            },
            {
                'folke/neodev.nvim',
                config = function() require('setup.neodev').setup() end
            },
        }
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        requires = {
            {'JoosepAlviste/nvim-ts-context-commentstring'},
        },
        config = function() require('setup.nvim-treesitter').setup() end
    }

    use {
        'nvim-treesitter/nvim-treesitter-context',
        config = function() require('setup.nvim-treesitter-context').setup() end
    }

    use 'nvim-treesitter/playground'

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        requires = {{'nvim-lua/plenary.nvim'}},
        config = function() require('setup.telescope').setup() end
    }

    use 'christoomey/vim-tmux-navigator'

    use {
        'lewis6991/gitsigns.nvim',
        config = function() require('setup.gitsigns').setup() end
    }

    use {
        'nvim-lualine/lualine.nvim',
        config = function() require('setup.lualine').setup() end
    }

    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function() require('setup.indent-blankline').setup() end
    }

    use {
        'numToStr/Comment.nvim',
        config = function() require('setup.comment').setup() end
    }

    use {
        'akinsho/git-conflict.nvim',
        tag = '*',
        config = function() require('setup.git-conflict').setup() end
    }

    use {
        'kylechui/nvim-surround',
        tag = "*",
        config = function() require('setup.nvim-surround').setup() end
    }

    use {
        'folke/flash.nvim',
        config = function() require('setup.flash').setup() end
    }

    use {
        'embark-theme/vim',
        as = 'emabrk'
    }
end)
