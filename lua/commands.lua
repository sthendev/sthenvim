vim.api.nvim_create_user_command('TrimWhitespace', '%s/\\s\\+$//e', {})
vim.api.nvim_create_user_command('LspRename', 'lua vim.lsp.buf.rename()', {})
