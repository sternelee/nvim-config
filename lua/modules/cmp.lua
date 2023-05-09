local lspkind = require('lspkind')

local cmp = require 'cmp'

require("cmp_git").setup()

local check_backspace = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local formatForTailwindCSS = function(entry, vim_item)
  if vim_item.kind == 'Color' and entry.completion_item.documentation then
    local _, _, r, g, b = string.find(entry.completion_item.documentation, '^rgb%((%d+), (%d+), (%d+)')
    if r then
      local color = string.format('%02x', r) .. string.format('%02x', g) .. string.format('%02x', b)
      local group = 'Tw_' .. color
      if vim.fn.hlID(group) < 1 then
        vim.api.nvim_set_hl(0, group, { fg = '#' .. color })
      end
      vim_item.kind = "●" -- or "■" or anything
      vim_item.kind_hl_group = group
      return vim_item
    end
  end
  -- vim_item.kind = icons[vim_item.kind] and (icons[vim_item.kind] .. vim_item.kind) or vim_item.kind
  -- or just show the icon
  vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
  return vim_item
end

local winhighlight = {
  winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
}

cmp.setup({
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }), {'i','s'}),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif check_backspace() then
        cmp.complete()
      else
        fallback()
      end
    end, {
      "i",
      "s"
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, {
      "i",
      "s"
    }),
  },
  sources = {
    { name = 'nvim_lsp', priority_weight = 10 },
    { name = 'vsnip' },
    { name = 'buffer', option = { keyword_length = 3 } },
    { name = 'nvim_lsp_signature_help' },
    { name = 'calc' },
    { name = 'emoji' },
    -- { name = 'spell' },
    -- { name = 'cmp_tabnine' },
    { name = 'git' },
    -- { name = 'digraphs' },
    -- { name = 'treesitter' },
    -- { name = 'look', keyword_length=4, option={convert_case=true, loud=true}},
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = lspkind.cmp_format({
      mode = 'symbol_text', -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      before = function(entry, vim_item)
        vim_item.menu = "(" .. vim_item.kind .. ")"
        vim_item.dup = ({
          nvim_lsp = 0,
          path = 0,
        })[entry.source.name] or 0
        vim_item = formatForTailwindCSS(entry, vim_item) -- for tailwind css autocomplete
        return vim_item
      end
    })
  },
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      require "cmp-under-comparator".under,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
  window = {
    -- border style
    completion = cmp.config.window.bordered({
      col_offset = -3, -- align the abbr and word on cursor (due to fields order below)
      side_padding = 0,
      bordered = winhighlight
    }),
    documentation = cmp.config.window.bordered(winhighlight),
  },
  experimental = {
    -- ghost_text = true
  }
})

-- for autopairs
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
})