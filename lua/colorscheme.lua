vim.cmd('colorscheme embark')

local highlights = {
    {'DiffDelete', {bg='#411e35'}, ctermbg=203},
    {'LeapLabelPrimary', {fg='#100e23', bg='#a1efd3', ctermfg=232, ctermbg=120}},
    {'LeapLabelSecondary', {fg='#100e23', bg='#d4bfff', ctermfg=232, ctermbg=143}},
    {'DiagnosticSignOk', {fg="#a1efd3", ctermfg=120}}
}

for _, highlight in ipairs(highlights) do
    local name, settings = unpack(highlight)
    vim.api.nvim_set_hl(0, name, settings)
end

