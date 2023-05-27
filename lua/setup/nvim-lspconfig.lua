local M = {}

local lspconfig = require('lspconfig')

M.config = {
    clangd = {},
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = {'vim'}
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true)
                },
            },
        },
    },
}

M.capabilities = vim.tbl_extend(
    'keep',
    {},
    require('cmp_nvim_lsp').default_capabilities()
)

function M.setup()
    for server, settings in pairs(M.config) do
        lspconfig[server].setup(settings)
    end
end

return M
