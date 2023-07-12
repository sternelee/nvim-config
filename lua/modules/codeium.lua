local keyset = vim.keymap.set
local fn = vim.fn
-- 都会自动触发，会卡
-- 注释掉 autocmd InsertEnter...等自动codeium#DebouncedComplete 那一行
vim.g.codeium_disable_bindings = 1
-- vim.g.codeium_manual = true
keyset("i", "<C-k>", function()
  return fn["codeium#Complete"]()
end, { expr = true })
keyset("i", "<C-g>", function()
  return fn["codeium#Accept"]()
end, { expr = true })
keyset("i", "<c-;>", function()
  return fn["codeium#CycleCompletions"](1)
end, { expr = true })
keyset("i", "<c-,>", function()
  return fn["codeium#CycleCompletions"](-1)
end, { expr = true })
keyset("i", "<c-x>", function()
  return fn["codeium#Clear"]()
end, { expr = true })
