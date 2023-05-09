require("typescript").setup({
    disable_commands = false,
    debug = false,
    go_to_source_definition = {
        fallback = true,
    },
    server = {
        -- pass options to lspconfig's setup method
        handlers = {
            ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
            ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" }),
        },
        capabilities = require("lsp/tsserver").capabilities,
        settings = require("lsp/tsserver").settings,
    },
})
