local M = {}

local cmp = require('cmp')

function M.setup()
    cmp.setup{
        snippet = {
            expand = function(args)
                vim.fn['vsnip#anonymous'](args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-n>'] = cmp.mapping.scroll_docs(-4),
            ['<C-p>'] = cmp.mapping.scroll_docs(4),
            ['<C-h>'] = cmp.mapping.complete(),
            ['<Tab>'] = cmp.mapping.confirm({select = true}),
        }),
        sources = cmp.config.sources({
            {name = 'nvim-lsp'},
            {name = 'vsnip'},
        }, {
            {name = 'buffer'},
        }),
    }
end

return M
