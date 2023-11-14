local null_ls = require("null-ls")
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md

-- https://livecode247.com/boost-your-neovim-experience-with-these-essential-plugins

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local function get_dprint_config_path()
  local path_separator = _G.IS_WINDOWS and "\\" or "/"
  local patterns = vim.tbl_flatten({ ".dprint.json", "dprint.json" })
  local config_path = vim.fn.stdpath("config") .. "/dprint.json"
  for _, name in ipairs(patterns) do
    if vim.loop.fs_stat(vim.loop.cwd() .. path_separator .. name) then
      config_path = vim.loop.cwd() .. path_separator .. name
    end
  end
  return { "--config", config_path }
end

-- require("null-ls").register({
--   name = "more_actions",
--   method = { require("null-ls").methods.CODE_ACTION },
--   filetypes = { "_all" },
--   generator = {
--     fn = require("ts-node-action").available_actions,
--   },
--   diagnostics_postprocess = function(diagnostic)
--     diagnostic.severity = vim.diagnostic.severity["HINT"]     -- ERROR, WARN, INFO, HINT
--   end,
-- })

null_ls.setup({
  debounce = 500,
  update_in_insert = true,
  sources = {
    -- diagnostics.eslint_d,
    -- formatting.eslint_d,
    -- code_actions.eslint_d,
    diagnostics.markdownlint,
    formatting.markdownlint,
    diagnostics.cspell.with({
      filetypes = { "*" },
      extra_args = { "--config", vim.fn.stdpath("config") .. "/cspell.json" },
      diagnostics_postprocess = function(diagnostic)
        diagnostic.severity = vim.diagnostic.severity["HINT"]         -- ERROR, WARN, INFO, HINT
      end,
    }),
    code_actions.cspell.with({
      config = {
        find_json = function(cwd)
          return vim.fn.stdpath("config") .. "/cspell.json"
        end,
      },
    }),
    formatting.jq,
    formatting.stylua.with({
      extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
    }),
    -- diagnostics.codespell, -- 这玩意有问题, datas 会被转成 data
    -- formatting.codespell,
    formatting.prettier,
    -- require("typescript.extensions.null-ls.code-actions"),
    -- formatting.prettierd.with({
    --   filetypes = { "html", "css", "scss" },
    --   extra_args = { "--print-width", "120" },
    -- }),
    formatting.dprint.with({
      filetypes = { "javascriptreact", "typescript", "typescriptreact", "json", "javascript" },
      extra_args = get_dprint_config_path(),
    }),
    -- code_actions.gitsigns,
  },
})
