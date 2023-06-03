return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'hrsh7th/vim-vsnip'

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'hrsh7th/cmp-cmdline'},
            {'hrsh7th/cmp-vsnip'},
            {'hrsh7th/cmp-nvim-lsp-signature-help'},
        },
        config = function() require('setup.nvim-cmp').setup() end
    }

    use {
        'nvim-lua/lsp-status.nvim',
        config = function() require('setup.lsp-status').setup() end
    }

    use {
        'neovim/nvim-lspconfig',
        config = function() require('setup.nvim-lspconfig').setup() end
    }

    use {
        'nvim-treesitter/nvim-treesitter',
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
        'embark-theme/vim',
        as = 'emabrk'
    }
end)
