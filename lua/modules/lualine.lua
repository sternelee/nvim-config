-- lualine config
local gps = require("nvim-gps")
gps.setup()

local gps_c = function()
  if gps.is_available() then
    return ' '..gps.get_location()
  end
  return ''
end

require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'horizon',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename', gps_c},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename', gps_c},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  -- theme = 'gruvbox-material',
  extensions = {'quickfix', 'fugitive'}
})