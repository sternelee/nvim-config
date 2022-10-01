require("indent_blankline").setup {
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
  use_treesitter = true,
  context_highlight_list = {
    'IndentBlanklineIndent1',
    'IndentBlanklineIndent2',
    'IndentBlanklineIndent3',
    'IndentBlanklineIndent4',
    'IndentBlanklineIndent5',
    'IndentBlanklineIndent6',
  },
  filetype_exculde = {
    'alpha',
    'packer',
    'NvimTree',
    'lsp-install',
    'help',
    'TelescopePrompt',
    'TelescopeResults',
  },
  buftype_exclude = { 'terminal', 'nofile' },
}
