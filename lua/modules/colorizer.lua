require'colorizer'.setup{
  filetypes = { "*" },
  user_default_options = {
    rgb_fn = true,
    hsl_fn = true,
    css = true,
    css_fn = true,
    tailwindcss = true,
    sass = { enable = true, parsers = { css } }
  }
}
