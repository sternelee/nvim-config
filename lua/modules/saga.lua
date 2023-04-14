-- {'glepnir/lspsaga.nvim', event = 'VeryLazy', branch = 'main', config = function() require 'modules.saga' end},
--
-- map('n', 'gD', '<cmd>Lspsaga peek_definition<CR>')
-- -- map('n', '<leader>l', '<cmd>Lspsaga lsp_finder<CR>')
-- map('n', 'ga', '<cmd>Lspsaga code_action<CR>')
-- map('x', 'gA', '<cmd>Lspsaga range_code_action<CR>')
-- map('n', 'K', '<cmd>Lspsaga hover_doc<CR>')
-- map('n', 'gr', '<cmd>Lspsaga rename<CR>')
-- map('n', 'gi', '<cmd>Lspsaga peek_type_definition<CR>')
-- map('n', 'gC', '<cmd>Lspsaga show_cursor_diagnostics<CR>')
-- map('n', 'ge', '<cmd>Lspsaga show_line_diagnostics<CR>')
-- map('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>')
-- map('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>')
-- map('n', '<leader>ts', '<cmd>Lspsaga outline<CR>')
-- map('n', '<A-i>', '<cmd>Lspsaga term_toggle<CR>')
-- map('t', '<A-i>', '<C-\\><C-n><cmd>Lspsaga term_toggle<CR>')

local saga = require 'lspsaga'
saga.setup{
}
