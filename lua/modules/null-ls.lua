local null_ls = require("null-ls")
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md

-- https://livecode247.com/boost-your-neovim-experience-with-these-essential-plugins

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
-- local augroup = vim.api.nvim_create_augroup("NullForm", {})

null_ls.setup({
  debounce = 500,
  update_in_insert = true,
  sources = {
    -- diagnostics.eslint_d,
    -- formatting.eslint_d,
    -- code_actions.eslint_d,
    diagnostics.markdownlint,
    formatting.markdownlint,
    -- diagnostics.cspell.with({
    --   extra_args = { "--config", vim.fn.expand("~/.config/nvim/cspell.json") },
    -- }),
    -- code_actions.cspell.with({
    --   extra_args = { "--config", vim.fn.expand("~/.config/nvim/cspell.json") },
    -- }),
    diagnostics.codespell,
    formatting.codespell,
    -- formatting.prettier,
    formatting.stylua,
    formatting.prettierd,
    -- code_actions.gitsigns,
  },
    -- on_attach = function(client, bufnr)
    --   if client.supports_method("textDocument/formatting") then
    --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    --     vim.api.nvim_create_augroup("BufWritePre", {
    --       group = augroup,
    --       buffer = bufnr,
    --       callback = function()
    --         vim.lsp.buf.format({ bufnr = bufnr })
    --       end,
    --     })
    --   end
    -- end,
})
