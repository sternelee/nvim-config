-- 该插件 hover doc没有语法高亮
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
    client.server_capabilities.semanticTokensProvider = true
  end,
  capabilities = require("lsp/tsserver").capabilities,
  settings = {
    separate_diagnostic_server = true,
    publish_diagnostic_on = "insert_leave",
    expose_as_code_action = {},
    tsserver_path = nil,
    tsserver_plugins = {},
    tsserver_max_memory = "auto",
    tsserver_format_options = {
      includeInlayParameterNameHints = "all",
      includeCompletionsForModuleExports = true,
      quotePreference = "auto",
    },
    tsserver_file_preferences = {
      allowIncompleteCompletions = false,
      allowRenameOfImportPath = false,
    },
  },
})