local M = {}

local colors = {
  fg     = '#CBE3E7',
  bg     = '#100E23',
  blue   = '#91DDFF',
  green  = '#A1EFD3',
  purple = '#D4BFFF',
  red    = '#F48FB1',
  yellow = '#FFE6B3',
  gray1  = '#100E23',
  gray2  = '#2D2B40',
}

local theme = {
  normal = {
    a = { fg = colors.bg, bg = colors.blue, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.gray2 },
    c = { fg = colors.fg, bg = colors.gray1 },
  },
  insert = {
    a = { fg = colors.bg, bg = colors.green, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.gray2 },
  },
  visual = {
    a = { fg = colors.bg, bg = colors.purple, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.gray2 },
  },
  replace = {
    a = { fg = colors.bg, bg = colors.red, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.gray2 },
  },
  inactive = {
    a = { fg = colors.fg, bg = colors.bg, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.fg, bg = colors.gray1 },
  },
}

local function lspstatus()
    return require('lsp-status').status()
end

function M.setup()
    require('lualine').setup{
        options = {
            icons_enabled = true,
            theme = theme,
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            }
        },
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'diff', 'diagnostics'},
            lualine_c = {'filename'},
            lualine_x = { lspstatus, 'encoding', 'fileformat', 'filetype'},
            lualine_y = {'progress'},
            lualine_z = {'location'}
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
    }
end

return M
