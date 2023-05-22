--[[ local prettier = function ()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote'},
    stdin = true
  }
end ]]
-- npm install -g @fsouza/prettierd
local prettierd = function()
  return {
    exe = "prettierd",
    args = { vim.api.nvim_buf_get_name(0) },
    stdin = true,
  }
end

require("formatter").setup({
  filetype = {
    javascript = {
      prettierd,
    },
    javascriptreact = {
      prettierd,
    },
    typescript = {
      prettierd,
    },
    typescriptreact = {
      prettierd,
    },
    vue = {
      prettierd,
    },
    json = {
      prettierd,
    },
    html = {
      prettierd,
    },
    css = {
      prettierd,
    },
    sass = {
      prettierd,
    },
    scss = {
      prettierd,
    },
    less = {
      prettierd,
    },
    rust = {
      prettierd,
    },
  },
})
