require'nvim-tree'.setup {
  auto_reload_on_write = true,
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  system_open = {
    cmd  = nil,
    args = {}
  },
  -- view = {
  --   side = 'right'
  -- },
  filters = {
    dotfiles = false,
    custom = {"^\\.git"},
    exclude = {},
  }
}
