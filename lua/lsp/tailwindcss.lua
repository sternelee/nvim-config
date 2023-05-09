local M = {}

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.colorProvider = { dynamicRegistration = false }

-- Settings
local filetypes = {
    "astro",
    "astro-markdown",
    "html",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
    "rust",
    "rs",
}

local init_options = {
    userLanguages = {
        eelixir = "html-eex",
        eruby = "erb",
    },
}

local settings = {
    tailwindCSS = {
        lint = {
            cssConflict = "warning",
            invalidApply = "error",
            invalidConfigPath = "error",
            invalidScreen = "error",
            invalidTailwindDirective = "error",
            invalidVariant = "error",
            recommendedVariantOrder = "warning",
        },
        experimental = {
            classRegex = {
                [[class="([^"]*)]],
                'class=\\s+"([^"]*)',
                "tw`([^`]*)",
                'tw="([^"]*)',
                'tw={"([^"}]*)',
                "tw\\.\\w+`([^`]*)",
                "tw\\(.*?\\)`([^`]*)",
            },
        },
        validate = true,
    },
}

M.filetypes = filetypes
M.capabilities = capabilities
M.settings = settings
M.init_options = init_options

return M
