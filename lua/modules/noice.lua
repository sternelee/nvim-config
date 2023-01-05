require("noice").setup {
  -- messages = { enabled = false, view_error = nil },
  lsp_progress = { enabled = false },
  -- cmdline = { enabled = false },
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
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
      ["vim.lsp.util.stylize_markdown"] = false,
      ["cmp.entry.get_documentation"] = false,
    },
  },
  presets = {
    bottom_search = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = false,
  },
  throttle = 500
}
