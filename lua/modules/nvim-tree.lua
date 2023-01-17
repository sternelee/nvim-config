require'nvim-tree'.setup {
  auto_reload_on_write = true,
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  sync_root_with_cwd  = true,
  respect_buf_cwd     = true,
  system_open = {
    cmd  = nil,
    args = {}
  },
  update_focused_file = {
    enable      = true,
    update_cwd  = true,
    update_root = true,
    ignore_list = { ".git", "node_modules", ".cache" },
  },
  -- view = {
  --   side = 'right'
  -- }
}
