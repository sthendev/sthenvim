local telescope = require('telescope.builtin')
local telescope_custom = require('setup.telescope')

local keybindings = {
    {'n', '<leader>ff', telescope_custom.project_files, {}},
    {'n', '<leader>fg', telescope.live_grep, {}},
    {'n', '<leader>fb', telescope.buffers, {}},

    {'n', '<leader>yy', '"+yy', {}},
    {'n', '<leader>dd', '"+dd', {}},
    {'n', '<leader>p', '"+p', {}},
    {'n', '<leader>P', '"+P', {}},

    {'n', '<leader>dk', vim.diagnostic.goto_prev, {}},
    {'n', '<leader>dj', vim.diagnostic.goto_next, {}},
    {'n', '<leader>do', vim.diagnostic.open_float, {}},

    {'v', '<leader>y', '"+y', {}},
    {'v', '<leader>d', '"+d', {}},
    {'v', '<leader>p', '"+p', {}},
    {'v', '<leader>P', '"+P', {}},
}

local function bind(mode, key, fn, args)
    vim.keymap.set(mode, key, fn, args)
end

for _, v in ipairs(keybindings) do
    bind(unpack(v))
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = {buffer = ev.buf}
        bind('n', 'gD', vim.lsp.buf.declaration, opts)
        bind('n', 'gd', vim.lsp.buf.definition, opts)
        bind('n', 'gh', vim.lsp.buf.hover, opts)
        bind('n', 'gi', vim.lsp.buf.implementation, opts)
        bind('n', 'gr', vim.lsp.buf.references, opts)
    end,
})
