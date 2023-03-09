local null_ls = require("null-ls")
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

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
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    vim.lsp.buf.formatting_sync()
                end,
            })
        end
    end,
})
