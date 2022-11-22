local keyset = vim.keymap.set
local remap = vim.api.nvim_set_keymap
local usercmd = vim.api.nvim_create_user_command

-- Auto complete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

local opts = {silent = true, noremap = true, expr = true}
remap("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
remap("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

remap("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

keyset("n", "[d", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]d", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation.
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

keyset("n", "gh", "<Plug>(coc-references)", {silent = true})

keyset("n", "gf", ":CocCommand eslint.executeAutofix<CR>", {})
keyset("n", "gj", ":CocCommand tsserver.goToSourceDefinition<CR>", {silent = true})

-- Use K to show documentation in preview window.
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

-- Highlight the symbol and its references when holding the cursor.
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})

-- Formatting selected code.
keyset("x", "fo", "<Plug>(coc-format-selected)", {silent = true})
keyset("n", "fo", "<Plug>(coc-format-selected)", {silent = true})

-- Setup formatexpr specified filetype(s).
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder.
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

-- Applying codeAction to the selected region.
-- Example: `<leader>aap` for current paragraph
local opts = {silent = true, nowait = true}
keyset("x", "<leader>ca", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<leader>ca", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for applying codeAction to the current buffer.
keyset("n", "<leader>ac", "<Plug>(coc-codeaction)", opts)

-- Apply AutoFix to problem on the current line.
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

-- Run the Code Lens action on the current line.
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)

-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)

-- Remap <C-f> and <C-b> for scroll float windows/popups.
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true, expr = true}
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)


-- Use CTRL-S for selections ranges.
-- Requires 'textDocument/selectionRange' support of language server.
-- keyset("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
-- keyset("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})

-- Add `:Format` command to format current buffer.
usercmd("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer.
usercmd("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

-- Add `:OR` command for organize imports of the current buffer.
usercmd("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

usercmd("Prettier", ":CocCommand prettier.formatFile", {})

-- Add (Neo)Vim's native statusline support.
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline.
-- vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
-- local opts = {silent = true, nowait = true}
-- Show all diagnostics.
-- keyset("n", "<leader>a", ":<C-u>CocList diagnostics<cr>", opts)
-- Manage extensions.
-- keyset("n", "<leader>e", ":<C-u>CocList extensions<cr>", opts)
-- Show commands.
-- keyset("n", "<leader>c", ":<C-u>CocList commands<cr>", opts)
-- Find symbol of current document.
-- keyset("n", "<leader>o", ":<C-u>CocList outline<cr>", opts)
-- Search workspace symbols.
-- keyset("n", "<leader>s", ":<C-u>CocList -I symbols<cr>", opts)
-- Do default action for next item.
-- keyset("n", "<leader>j", ":<c-u>CocNext<cr>", opts)
-- Do default action for previous item.
-- keyset("n", "<leader>k", ":<C-u>CocPrev<cr>", opts)
-- Resume latest coc list.
-- keyset("n", "<leader>p", ":<C-u>CocListResume<cr>", opts)

-- coc-winbar by coc-symbol-line
function _G.symbol_line()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
  local ok, line = pcall(vim.api.nvim_buf_get_var, bufnr, 'coc_symbol_line')
  return ok and '%#CocSymbolLine# ' .. line or ''
end

if vim.fn.exists '&winbar' then
  vim.api.nvim_create_autocmd({'CursorHold', 'WinEnter', 'BufWinEnter'}, {
    pattern = "*",
    callback = function()
      if vim.b.coc_symbol_line and vim.bo.buftype == '' then
        if vim.opt_local.winbar:get() == '' then
          vim.opt_local.winbar = '%!v:lua.symbol_line()'
        end
      else
        vim.opt_local.winbar = ''
      end
    end,
    desc = "Winbar Info",
  })
end
