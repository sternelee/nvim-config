local disableTsOrLsp = function (lang, bufnr)
  local lcount = vim.api.nvim_buf_line_count(bufnr)
  local bytes = vim.api.nvim_buf_get_offset(bufnr, lcount)
  return bytes / lcount > 500
end

-- local present, ts_config = pcall(require, "nvim-treesitter.configs")
-- if not present then
--   return
-- end
--nvim treesitter 编辑大文件卡顿时最好关闭 highlight, rainbow, autotag
require('nvim-treesitter.configs').setup {
  parser_install_dir = "~/.local/share/nvim/parsers",
  -- ensure_installed = {"vue", "html", "javascript", "typescript", "scss", "json", "rust", "lua", "tsx", "dockerfile", "graphql", "jsdoc", "toml", "comment", "yaml", "cmake", "bash", "http", "dot", "help", "vim", "query"},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = disableTsOrLsp,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
    disable = disableTsOrLsp,
  },
  autotag = {
    enable = true,
    disable = disableTsOrLsp,
  },
  indent = {
    enable = true,
    disable = disableTsOrLsp,
  },
  incremental_selection = {
    enable = false
  },
  context_commentstring = {
    enable = false
  },
}
vim.opt.runtimepath:append("~/.local/share/nvim/parsers")
