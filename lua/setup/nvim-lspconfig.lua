local M = {}

local lspconfig = require('lspconfig')
local settings = require('settings')

M.config = {
    ccls = {
        init_options = {
            index = {
                initialBlacklist = settings.get_config('ccls_initial_blacklist')
            }
        }
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
    pyright = {
        analysis = {
            autoImportCompletions = false
        }
    },
    cmake = {}
}

M.capabilities = vim.tbl_extend(
    'keep',
    {},
    require('cmp_nvim_lsp').default_capabilities()
)

function M.setup()
    for server, settings in pairs(M.config) do
        settings.capabilities = M.capabilities
        lspconfig[server].setup(settings)
    end
end

return M
