local api = require("typescript-tools.api")
require("typescript-tools").setup({
  handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" }),
    ["textDocument/publishDiagnostics"] = api.filter_diagnostics({ 80006 }),
  },
  on_attach = function(client, bufnr)
    local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
    end
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
    client.server_capabilities.semanticTokensProvider = nil
    if client and client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(bufnr, true)
    end
  end,
  capabilities = require("lsp/tsserver").capabilities,
  settings = {
    separate_diagnostic_server = true,
    publish_diagnostic_on = "insert_leave",
    expose_as_code_action = {},
    -- tsserver_path = "~/.local/share/nvim/mason/bin/typescript-language-server",
    tsserver_path = nil,
    tsserver_plugins = {},
    tsserver_max_memory = "auto",
    tsserver_format_options = {
      -- https://github.com/microsoft/TypeScript/blob/v5.0.4/src/server/protocol.ts#L3418
      allowIncompleteCompletions = false,
      allowRenameOfImportPath = false,
    },
    tsserver_file_preferences = {
      -- https://github.com/microsoft/TypeScript/blob/v5.0.4/src/server/protocol.ts#L3439
      -- includeInlayParameterNameHints = "all",
      -- includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      -- includeInlayFunctionParameterTypeHints = true,
      -- includeInlayVariableTypeHints = true,
      -- includeInlayVariableTypeHintsWhenTypeMatchesName = true,
      -- includeInlayPropertyDeclarationTypeHints = true,
      -- includeInlayFunctionLikeReturnTypeHints = true,
      -- includeInlayEnumMemberValueHints = true,
      includeCompletionsForModuleExports = true,
      organizeImportsIgnoreCase = "auto",
      quotePreference = "auto",
      includePackageJsonAutoImports = "auto",
      allowRenameOfImportPath = true,
      allowIncompleteCompletions = false,
    },
  },
})
