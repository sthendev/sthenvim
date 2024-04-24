local settings = require('settings')
local telescope = require('telescope.builtin')
local ls = require('luasnip')

local keybindings = {
    {'n', '<leader>ff', telescope.find_files},
    {'n', '<leader>fg', telescope.live_grep},
    {'n', '<leader>fb', telescope.buffers},

    {'n', '<leader>yy', '"+yy'},
    {'n', '<leader>dd', '"+dd'},
    {'n', '<leader>p', '"+p'},
    {'n', '<leader>P', '"+P'},

    {'n', '<leader>dk', vim.diagnostic.goto_prev},
    {'n', '<leader>dj', vim.diagnostic.goto_next},
    {'n', '<leader>do', vim.diagnostic.open_float},

    {'n', '<leader>ck', ':GitConflictPrevConflict<CR>'},
    {'n', '<leader>cj', ':GitConflictNextConflict<CR>'},
    {'n', '<leader>cc', ':GitConflictChooseOurs<CR>'},
    {'n', '<leader>ci', ':GitConflictChooseTheirs<CR>'},

    {'n', '<leader>gg', ':FloatermNew --name=git lazygit<CR>'},
    {'t', '<C-w><C-w>', '<C-\\><C-n>:FloatermToggle term<CR>'},
    {'n', '<C-w><C-w>', ':FloatermToggle term<CR>'},

    {'n', '<C-w><C-h>', ':vertical resize -5<CR>'},
    {'n', '<C-w><C-l>', ':vertical resize +5<CR>'},
    {'n', '<C-w><C-j>', ':resize -5<CR>'},
    {'n', '<C-w><C-k>', ':resize +5<CR>'},

    {'v', '<leader>y', '"+y'},
    {'v', '<leader>d', '"+d'},
    {'v', '<leader>p', '"+p'},
    {'v', '<leader>P', '"+P'},

    {'i', '<C-j>', '<nop>'},
    {'i', '<C-k>', '<nop>'},

    {'i', '<C-l>', function() ls.jump(1) end},
    {'s', '<C-l>', function() ls.jump(1) end},
    {'i', '<C-h>', function() ls.jump(-1) end},
    {'i', '<C-h>', function() ls.jump(-1) end},
}

for _, v in ipairs(keybindings) do
    vim.keymap.set(unpack(v))
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = {buffer = ev.buf}
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    end,
})

if settings.get_config('trim_whitespace_on_write') then
    vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*',
        command = ':%s/\\s\\+$//e'
    })
end
