local null_ls = require("null-ls")
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md

null_ls.setup({
    sources = {
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.diagnostics.markdownlint,
        -- null_ls.builtins.diagnostics.cspell.with({
        --   extra_args = { "trace", "--config", vim.fn.expand("~/.config/nvim/cspell.json") },
        -- }),
        -- null_ls.builtins.code_actions.cspell.with({
        --   extra_args = { "trace", "--config", vim.fn.expand("~/.config/nvim/cspell.json") },
        -- }),
        null_ls.builtins.diagnostics.codespell,
        -- null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.prettierd,
        -- null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.code_actions.gitsigns,
    },
    -- on_attach = function (server, bufnr)
    --   if server.server_capabilities.documentFormattingProvider then
    --     vim.keymap.set('n', '==', function ()
    --       vim.lsp.buf.format({ async = ''})
    --     end)
    --   end
    -- end
})
