return require('packer').startup(function(use)
    -- packer can manage itself
    use 'wbthomason/packer.nvim'

    -- hex colorizer
    use { 'RRethy/vim-hexokinase', run='make hexokinase' }

		-- themes
		use { 'sainnhe/gruvbox-material' }
		use { '~/projects/mariana.vim' }

		-- blame
		use { 'tveskag/nvim-blame-line' }

end)
