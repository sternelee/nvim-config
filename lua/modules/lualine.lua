-- lualine config
require('lualine').setup({
  options = {
    theme = 'auto',
    icons_enabled = true,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = {'mode',
      function ()
        local animated = {"💕", "💞", "💓", "💗", "💖"}
        return animated[os.date("%S") % #animated + 1]
      end
    },
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filesize', 'filename', 'b:coc_current_function', 'g:coc_status'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
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
  extensions = {'quickfix', 'fugitive'}
})
