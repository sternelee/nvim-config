local cspell = require('lint').linters.cspell
cspell.args = {
  '-c ~/.config/nvim/cspell.json',
  '-v',
  '-'
}
require('lint').linters_by_ft = {
  markdown = { 'markdownlint' },
  html = { 'eslint_d', 'cspell' },
  javascript = { 'eslint_d', 'cspell' },
  typescript = { 'eslint_d', 'cspell' },
  vue = { 'eslint_d', 'cspell' },
  json = { 'jsonlint', 'cspell' }
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
