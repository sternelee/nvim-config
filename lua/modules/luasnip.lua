local luasnip = require("luasnip")

-- forget the current snippet when leaving the insert mode. ref: https://github.com/L3MON4D3/LuaSnip/issues/656#issuecomment-1313310146
local unlinkgrp = vim.api.nvim_create_augroup(
  'UnlinkSnippetOnModeChange',
  { clear = true }
)

vim.api.nvim_create_autocmd('ModeChanged', {
  group = unlinkgrp,
  pattern = { 's:n', 'i:*' },
  desc = 'Forget the current snippet when leaving the insert mode',
  callback = function(evt)
    if luasnip.session
        and luasnip.session.current_nodes[evt.buf]
        and not luasnip.session.jump_active
    then
      luasnip.unlink_current()
    end
  end,
})


luasnip.filetype_extend("typescriptreact", { "html", "typescript" })
luasnip.filetype_extend("javascriptreact", { "html", "javascript" })

require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.set_config({
  region_check_events = 'CursorMoved'
})
