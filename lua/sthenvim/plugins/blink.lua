return {
    "saghen/blink.cmp",
    version = "1.*",
    opts = {
        keymap = {
            preset = "none",
            ["<C-SPACE>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-q>"] = { "hide", "fallback" },

            ["<TAB>"] = {
              function(cmp)
                if cmp.snippet_active() then return cmp.accept()
                else return cmp.select_and_accept() end
              end,
              "snippet_forward",
              "fallback"
            },
            ["<S-TAB>"] = { "snippet_backward", "fallback" },
            ["<UP>"] = { "select_prev", "fallback" },
            ["<DOWN>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
            ["<C-j>"] = { "select_next", "fallback_to_mappings" },
            ["<C-p>"] = { "scroll_documentation_up", "fallback" },
            ["<C-n>"] = { "scroll_documentation_down", "fallback" },
        },
        sources = {
            default = { "lsp", "path", "buffer" },
        },
        signature = {
            enabled = true
        },
        completion = {
            menu = {
                border = "none"
            }
        }
    }
}
