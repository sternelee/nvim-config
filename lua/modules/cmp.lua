local lspkind = require("lspkind")

local luasnip = require("luasnip")
local cmp = require("cmp")

require("cmp_git").setup()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

local formatForTailwindCSS = function(entry, vim_item)
  if vim_item.kind == "Color" and entry.completion_item.documentation then
    local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
    if r then
      local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
      local group = "Tw_" .. color
      if vim.fn.hlID(group) < 1 then
        vim.api.nvim_set_hl(0, group, { fg = "#" .. color })
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
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.close(),
      c = cmp.mapping.close(),
    }),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item()
      elseif luasnip.jumpable(1) then
        luasnip.jump(1)
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif luasnip.expandable() then
        luasnip.expand()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  sources = {
		{ name = "nvim_lsp" },
		{ name = "codeium", max_item_count = 3 },
    { name = "buffer" },
		-- { name = "luasnip", option = { use_show_condition = false } },
		{ name = "nvim_lua" },
		{ name = "path" },
    { name = "nvim_lsp_signature_help" },
    { name = "calc" },
    { name = "emoji" },
    -- { name = 'cmp_tabnine' },
    { name = "git" },
    -- { name = 'digraphs' },
    -- { name = 'treesitter' },
    -- { name = 'look', keyword_length=4, option={convert_case=true, loud=true}},
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = lspkind.cmp_format({
        symbol_map = { Copilot = "", Codeium = "", Snippet = "", Keyword = "" },
        preset = "codicons",
        maxwidth = 40,
        before = function(entry, vim_item)
          vim_item.menu = "(" .. vim_item.kind .. ")"
          vim_item.dup = ({
            nvim_lsp = 0,
            path = 0,
          })[entry.source.name] or 0
          vim_item = formatForTailwindCSS(entry, vim_item)     -- for tailwind css autocomplete
          return vim_item
        end,
      })(entry, vim_item)
      local strings = vim.split(vim_item.kind, "%s+", { trimempty = true })
      kind.kind = " " .. string.format("%s │", strings[1], strings[2]) .. " "
      return kind
    end,
  },
  matching = {
    disallow_fuzzy_matching = true,
    disallow_fullfuzzy_matching = true,
    disallow_partial_fuzzy_matching = false,
    disallow_partial_matching = false,
    disallow_prefix_unmatching = true,
  },
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.under,
      require("cmp-under-comparator").under,
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
    completion = cmp.config.window.bordered({
      col_offset = -3,       -- align the abbr and word on cursor (due to fields order below)
      side_padding = 0,
      bordered = winhighlight,
    }),
    documentation = cmp.config.window.bordered(winhighlight),
  },
  experimental = {
    ghost_text = true,
  },
})

-- for autopairs
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

cmp.setup.filetype("gitcommit", {
  sources = {
    { name = "git",             max_item_count = 10 },
    { name = "buffer",          max_item_count = 10 },
    { name = "cmdline_history", max_item_count = 10 },
  },
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer",          max_item_count = 10 },
    { name = "cmdline_history", max_item_count = 10 },
    { name = "path",            max_item_count = 10 },
    { name = "nvim_lua",        max_item_count = 10 },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "cmdline",         max_item_count = 10 },
    { name = "cmdline_history", max_item_count = 10 },
    { name = "path",            max_item_count = 10 },
    { name = "nvim_lua",        max_item_count = 10 },
    { name = "buffer",          max_item_count = 10 },
  },
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "*.toml",
    callback = function()
        require("cmp").setup.buffer({ sources = { { name = "crates" } } })
    end,
    desc = "Add cmp source for toml",
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "*.json",
    callback = function()
        require("cmp").setup.buffer({ sources = { { name = "npm", keyword_length = 3 } } })
    end,
    desc = "Add cmp source for json",
})
