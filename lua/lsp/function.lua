local M = {}

function M.format ()
      local buf = vim.api.nvim_get_current_buf()
      local ft = vim.bo[buf].filetype
      local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0
      vim.lsp.buf.format({
        bufnr = buf,
        timeout_ms = 5000,
        filter = function(client)
          if have_nls then
            return client.name == "null-ls"
          end
          return client.name ~= "null-ls"
        end,
      })
end

function M.enable_format_on_save()
  local group = vim.api.nvim_create_augroup("format_on_save", { clear = false })
  vim.api.nvim_create_autocmd("BufWritePre", {
    callback = M.format,
    group = group,
  })
  require("notify")("Enabled format on save", "info", { title = "LSP", timeout = 2000 })
end

function M.disable_format_on_save()
  vim.api.nvim_del_augroup_by_name("format_on_save")
  require("notify")("Disabled format on save", "info", { title = "LSP", timeout = 2000 })
end

function M.toggle_format_on_save()
  if vim.fn.exists("#format_on_save#BufWritePre") == 0 then
    M.enable_format_on_save()
  else
    M.disable_format_on_save()
  end
end

-- 切换保存时自动格式化
vim.api.nvim_create_user_command("AutoFormat", 'lua require("lsp.function").toggle_format_on_save()', {})

vim.api.nvim_create_user_command("Format", "lua vim.lsp.buf.format({ async = true })", {})
vim.api.nvim_create_user_command("FormatFile", 'lua require("lsp.function").format()', {})

function M.enable_eslint_on_save()
  local group = vim.api.nvim_create_augroup("eslint_on_save", { clear = false })
  vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
      local buf = vim.api.nvim_get_current_buf()
      local eslint_ok = vim.lsp.get_active_clients { bufnr = buf, name = "eslint" }
      if eslint_ok then
        vim.cmd("EslintFixAll")
      end
    end,
    group = group,
  })
  require("notify")("Enabled EslintAutoFix on save", "info", { title = "LSP", timeout = 2000 })
end

function M.disable_eslint_on_save()
  vim.api.nvim_del_augroup_by_name("eslint_on_save")
  require("notify")("Disabled EslintAutoFix on save", "info", { title = "LSP", timeout = 2000 })
end

function M.toggle_eslint_on_save()
  if vim.fn.exists("#eslint_on_save#BufWritePre") == 0 then
    M.enable_eslint_on_save()
  else
    M.disable_eslint_on_save()
  end
end

-- 切换保存时自动EsLintFix
vim.api.nvim_create_user_command("AutoEslintFix", 'lua require("lsp.function").toggle_eslint_on_save()', {})

-- dapui
vim.api.nvim_create_user_command("DapOpen", 'lua require("dapui").open()', {})
vim.api.nvim_create_user_command("DapClose", 'lua require("dapui").close()', {})
vim.api.nvim_create_user_command("DapToggle", 'lua require("dapui").toggle()', {})

-- Custom textDocument/hover LSP handler to colorize colors inside hover results - WIP
function M.custom_hover_handler(_, result)
  local handler = function(_, result)
    if result then
      local lines = vim.split(result.contents.value, "\n")
      local bufnr = vim.lsp.util.open_floating_preview(lines, "markdown", { border = "rounded" })
      require("colorizer").highlight_buffer(
        bufnr,
        nil,
        vim.list_slice(lines, 2, #lines),
        0,
        require("colorizer").get_buffer_options(0)
      )
    end
  end

  return handler
end

return M
