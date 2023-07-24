-- https://github-wiki-see.page/m/neovim/nvim-lspconfig/wiki/UI-customization
-- Diagnostic config
local codes = {
  no_matching_function = {
    message = " Can't find a matching function",
    "redundant-parameter",
    "ovl_no_viable_function_in_call",
  },
  empty_block = {
    message = " That shouldn't be empty here",
    "empty-block",
  },
  missing_symbol = {
    message = " Here should be a symbol",
    "miss-symbol",
  },
  expected_semi_colon = {
    message = " Please put the `;` or `,`",
    "expected_semi_declaration",
    "miss-sep-in-table",
    "invalid_token_after_toplevel_declarator",
  },
  redefinition = {
    message = " That variable was defined before",
    icon = " ",
    "redefinition",
    "redefined-local",
    "no-duplicate-imports",
    "@typescript-eslint/no-redeclare",
    "import/no-duplicates",
  },
  no_matching_variable = {
    message = " Can't find that variable",
    "undefined-global",
    "reportUndefinedVariable",
  },
  trailing_whitespace = {
    message = " Whitespace are useless",
    "trailing-whitespace",
    "trailing-space",
  },
  unused_variable = {
    message = "  Don't define variables you don't use",
    icon = "  ",
    "unused-local",
    "@typescript-eslint/no-unused-vars",
    "no-unused-vars",
  },
  unused_function = {
    message = "  Don't define functions you don't use",
    "unused-function",
  },
  useless_symbols = {
    message = " Remove that useless symbols",
    "unknown-symbol",
  },
  wrong_type = {
    message = " Try to use the correct types",
    "init_conversion_failed",
  },
  undeclared_variable = {
    message = " Have you declared that variable somewhere?",
    "undeclared_var_use",
  },
  lowercase_global = {
    message = " Should that be a global? (if so make it uppercase)",
    "lowercase-global",
  },
  -- Typescript
  no_console = {
    icon = "  ",
    "no-console",
  },
  -- Prettier
  prettier = {
    icon = "  ",
    "prettier/prettier",
  },
}

local format = function(diagnostic)
  local code = diagnostic.code

  if not diagnostic.source or not code then
    return string.format("%s", diagnostic.message)
  end

  if diagnostic.source == "eslint" then
    for _, table in pairs(codes) do
      if vim.tbl_contains(table, code) then
        return string.format("%s [%s]", table.icon .. diagnostic.message, code)
      end
    end

    return string.format("%s [%s]", diagnostic.message, code)
  end

  for _, table in pairs(codes) do
    if vim.tbl_contains(table, code) then
      return table.message
    end
  end

  return string.format("%s [%s]", diagnostic.message, diagnostic.source)
end

-- lsp UI
vim.diagnostic.config({
  underline = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
  float = false,
  -- float = {
  -- 	border = "rounded",
  -- 	source = "always", -- Or "if_many"
  -- 	prefix = " - ",
  -- 	format = format,
  -- },
  virtual_lines = {
    format = format,
    only_current_line = false,
    highlight_whole_line = true,
  },
  virtual_text = false,
  -- virtual_text = {
  --   spacing = 4,
  --   prefix = "●",
  --   source = "if_many",
  --   format = format
  -- },
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- lspconfig
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local lspconfig = require("lspconfig")
local lsputil = require("lspconfig.util")

vim.lsp.set_log_level('debug')

require("neodev").setup({})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "html", "cssls", "jsonls", "tsserver", "emmet_ls" },
  automatic_installation = true,
})

require("lspconfig.ui.windows").default_options.border = "rounded"

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" }),
}

local on_attach = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  client.server_capabilities.semanticTokensProvider = false

  if client.name == "tailwindcss" then
    if client.server_capabilities.colorProvider then
      require("lsp/documentcolors").buf_attach(bufnr)
    end
  end

  -- https://www.reddit.com/r/neovim/comments/14e41rb/today_on_nightly_native_lsp_inlay_hint_support/?utm_name=androidcss
  -- vim.api.nvim_create_augroup("lsp_augroup", { clear = true })
  --
  -- vim.api.nvim_create_autocmd("InsertEnter", {
  --   buffer = bufnr,
  --   callback = function() vim.lsp.inlay_hint(bufnr, true) end,
  --   group = "lsp_augroup",
  -- })
  -- vim.api.nvim_create_autocmd("InsertLeave", {
  --   buffer = bufnr,
  --   callback = function() vim.lsp.inlay_hint(bufnr, false) end,
  --   group = "lsp_augroup",
  -- })
end

local servers = {
  "lua_ls",
  "html",
  "cssls",
  "jsonls",
  "emmet_ls",
  "vuels",
  "volar",
  -- "tsserver",
  "denols",
  "rust_analyzer",
  "eslint",   -- 由null-ls来管理
  "tailwindcss",
  "bashls",
  "marksman",
  "pyright",
}

local function setup_servers()
  for _, lsp in ipairs(servers) do
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
      handlers = handlers,
    }
    if lsp == "jsonls" then
      opts.settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      }
    end
    -- if lsp == "tsserver" then
    --   opts.root_dir = lsputil.root_pattern("package.json", "tsconfig.json", "jsconfig.json")
    --   opts.capabilities = require("lsp/tsserver").capabilities
    --   opts.settings = require("lsp/tsserver").settings
    -- end
    if lsp == "denols" then
      opts.root_dir = lsputil.root_pattern("deno.json", "deno.jsonc")
    end
    if lsp == "vuels" then
      opts.root_dir = lsputil.root_pattern(".veturrc")
      opts.settings = require("lsp/vuels").settings
    end
    if lsp == "volar" then
      opts.root_dir = lsputil.root_pattern(".volarrc")
    end
    if lsp == "lua_ls" then
      -- opts.settings = require("lsp/lua_ls").settings
      opts.settings = {
        Lua = {
          completion = {
            callSnippet = "Replace"
          }
        }
      }
    end
    if lsp == "eslint" then
      opts.root_dir = lsputil.root_pattern(".eslintrc", ".eslintrc.js", ".eslintignore")
      opts.settings = require("lsp/eslint").settings
      opts.handlers = {
        ["window/showMessageRequest"] = function(_, result)
          return result
        end,
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" }),
      }
    end
    if lsp == "tailwindcss" then
      opts.root_dir = lsputil.root_pattern("tailwind.config.js", "tailwind.config.ts")
      opts.filetypes = require("lsp/tailwindcss").filetypes
      opts.capabilities = require("lsp/tailwindcss").capabilities
      opts.init_options = require("lsp/tailwindcss").init_options
      opts.settings = require("lsp/tailwindcss").settings
    end
    lspconfig[lsp].setup(opts)
  end
end

setup_servers()

require("lsp/function")

require("lsp-inlayhints").setup()
vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = "LspAttach_inlayhints",
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end

    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    require("lsp-inlayhints").on_attach(client, bufnr)
  end,
})
