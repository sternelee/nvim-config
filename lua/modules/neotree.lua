vim.g.neo_tree_remove_legacy_commands = 1

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticHint" })

require("neo-tree").setup({
  close_if_last_window = true,
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  sort_case_insensitive = false,
  default_component_configs = {
    container = { enable_character_fade = true },
    indent = {
      indent_size = 2,
      padding = 1,
      with_markers = false,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndent",
      with_expanders = true,
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeIndent",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
    },
    modified = {
      symbol = "●",
      highlight = "NeoTreeModified",
    },
    git_status = {
      symbols = {
        added = "",
        modified = "",
        deleted = "",
        renamed = "",
        untracked = "",
        ignored = "",
        unstaged = "",
        staged = "",
        conflict = "",
      },
    },
  },
  commands = {},
  window = {
    position = "left",
    width = 33,
    mappings = {
      ["o"] = "open",
      ["<c-x>"] = "open_split",
      ["<c-v>"] = "open_vsplit",
    },
  },
  filesystem = {
    filtered_items = {
      visible = false,
      hide_dotfiles = false,
      hide_gitignored = false,
      never_show = { ".git" },
    },
    follow_current_file = { enabled = true },
    group_empty_dirs = true,
    use_libuv_file_watcher = true,
    components = {
      name = function(config, node, state)
        local cc = require("neo-tree.sources.common.components")
        local result = cc.name(config, node, state)
        if node:get_depth() == 1 then
          result.text = string.gsub(state.path, "(.*[/\\])(.*)", "%2")
        end
        return result
      end,
    },
  },
  source_selector = {
    winbar = true,
    sources = {
      { source = "filesystem", display_name = "  Files " },
      { source = "buffers", display_name = "  Bufs " },
      { source = "git_status", display_name = "  Git " },
    },
  },
})
