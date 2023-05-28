local M = {}

local lspconfig = require('lspconfig')
local lsp_status = require('lsp-status')

M.config = {
    clangd = {
        handlers = lsp_status.extensions.clangd.setup(),
        init_options = {
            clangdFileStatus = true
        },
    },
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
    require('cmp_nvim_lsp').default_capabilities(),
    lsp_status.capabilities
)

function M.setup()
    for server, settings in pairs(M.config) do
        settings.capabilities = M.capabilities
        settings.on_attach = lsp_status.on_attach
        lspconfig[server].setup(settings)
    end
end

return M
