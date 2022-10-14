if vim.fn.has('termguicolors') then
	vim.o.termguicolors = true
end

return vim.cmd('colorscheme gruvbox-material')

