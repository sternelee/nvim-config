require("noice").setup {
  messages = { enabled = false },
  lsp_progress = { enabled = false },
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
     ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
     ["vim.lsp.util.stylize_markdown"] = true,
     ["cmp.entry.get_documentation"] = true,
   },
  },
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = true, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = true, -- add a border to hover docs and signature help
  },
}
