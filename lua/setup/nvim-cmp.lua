local M = {}

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')

function M.setup()
    cmp.setup{
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-j>'] = cmp.mapping.select_next_item(),
            ['<C-k>'] = cmp.mapping.select_prev_item(),
            ['<C-h>'] = cmp.mapping.complete(),
            ['<Tab>'] = cmp.mapping.confirm({select = true}),
        }),
        sources = cmp.config.sources({
            {name = 'nvim_lsp'},
            {name = 'nvim_lsp_signature_help'},
            {name = 'luasnip'},
        }, {
            {name = 'buffer'},
        }),
    }

    cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done{}
    )
end

return M
