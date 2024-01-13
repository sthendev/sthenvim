local table = require('table')

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- helper to simplify migration from packer
local plugins = {}
local function use(plugin_spec)
    table.insert(plugins, plugin_spec)
end

-- plugins
use {
    'embark-theme/vim',
    name = 'embark',
    laxy = false
}

use 'tpope/vim-sleuth'

use {
    'windwp/nvim-autopairs',
    config = function() require('setup.nvim-autopairs').setup() end
}

use {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-vsnip',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        {'L3MON4D3/LuaSnip', version='v2.*'}
    },
    config = function() require('setup.nvim-cmp').setup() end
}

use {
    'neovim/nvim-lspconfig',
    config = function() require('setup.nvim-lspconfig').setup() end,
    dependencies = {
        {
            'j-hui/fidget.nvim',
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
    config = function() require('setup.nvim-treesitter').setup() end
}

use {
    'nvim-treesitter/nvim-treesitter-context',
    config = function() require('setup.nvim-treesitter-context').setup() end
}

use 'nvim-treesitter/playground'

use {
    'nvim-telescope/telescope.nvim',
    version = '0.1.4',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
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
    version = '*',
    config = function() require('setup.git-conflict').setup() end
}

use {
    'kylechui/nvim-surround',
    version = '*',
    config = function() require('setup.nvim-surround').setup() end
}

use {
    'folke/flash.nvim',
    config = function() require('setup.flash').setup() end
}

use {
    'voldikss/vim-floaterm',
    config = function() require('setup.floaterm').setup() end
}

use 'sthendev/vim-todo'

require('lazy').setup(plugins)
