local null_ls = require("null-ls")
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md

-- https://livecode247.com/boost-your-neovim-experience-with-these-essential-plugins

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
-- local code_actions = null_ls.builtins.code_actions
-- local augroup = vim.api.nvim_create_augroup("NullForm", {})

local function get_dprint_config_path()
  local path_separator = _G.IS_WINDOWS and "\\" or "/"
  local patterns = vim.tbl_flatten({ ".dprint.json", "dprint.json" })
  local config_path = vim.fn.stdpath("config") .. "/lua/dprint.json"
  for _, name in ipairs(patterns) do
    if vim.loop.fs_stat(vim.loop.cwd() .. path_separator .. name) then
      config_path = vim.loop.cwd() .. path_separator .. name
    end
  end
  return { "--config", config_path }
end

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
    require("typescript.extensions.null-ls.code-actions"),
    formatting.prettierd.with({
      filetypes = { "html", "css", "scss" },
      extra_args = { "--print-width", "120" }
    }),
    formatting.dprint.with({
      filetypes = { "javascriptreact", "typescript", "typescriptreact", "json", "javascript" },
      extra_args = get_dprint_config_path(),
    }),
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
