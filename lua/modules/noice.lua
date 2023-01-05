require("noice").setup {
  -- messages = { enabled = false, view_error = nil },
  lsp_progress = { enabled = false },
  cmdline = { enabled = false },
  views = {
    messages = {
      view = "split",
      enter = true,
    },
    cmdline_popup = {
      position = {
        row = 8,
      },
    },
    popupmenu = {
      position = {
        row = 8,
      },
    }
  },
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
  throttle = 500
}
