local disableTsOrLsp = function (_, bufnr)
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
  -- ensure_installed = {"vue", "html", "javascript", "typescript", "scss", "json", "rust", "lua", "tsx", "dockerfile", "graphql", "jsdoc", "toml", "comment", "yaml", "cmake", "bash", "http", "dot"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = false,
    additional_vim_regex_highlighting = false,
    disable = disableTsOrLsp,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
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
