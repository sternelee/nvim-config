-- local disableTsOrLsp = function (_, bufnr)
--   local n = vim.api.nvim_buf_line_count(bufnr)
--   return  n > 10000 or n < 10 -- 大于一万行，或小于10行（可能是压缩的js文件）
-- end

--nvim treesitter 编辑大文件卡顿时最好关闭 highlight, rainbow, autotag
require('nvim-treesitter.configs').setup {
  ensure_installed = {"vue", "html", "javascript", "typescript", "scss", "json", "rust", "lua", "tsx", "dockerfile", "graphql", "jsdoc", "toml", "comment", "yaml", "cmake", "bash", "http", "dot"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    -- disable = disableTsOrLsp,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    -- disable = disableTsOrLsp,
  },
  autotag = {
    enable = true,
    -- disable = disableTsOrLsp,
  },
  indent = {
    enable = true,
    -- disable = disableTsOrLsp,
  },
  incremental_selection = {
    enable = false
  },
  context_commentstring = {
    enable = false
  },
}
