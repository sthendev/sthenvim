local utils = require('utils')

if utils.file_exists('nvimconfig.lua') then
    vim.cmd('luafile nvimconfig.lua')
end
