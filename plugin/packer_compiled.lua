-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/sternelee/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/sternelee/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/sternelee/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/sternelee/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/sternelee/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://gitcode.net/mirrors/numToStr/Comment.nvim"
  },
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim",
    url = "https://gitcode.net/mirrors/antoinemadec/FixCursorHold.nvim"
  },
  ["alpha-nvim"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/alpha-nvim",
    url = "https://gitcode.net/mirrors/goolord/alpha-nvim"
  },
  ["any-jump.vim"] = {
    commands = { "AnyJump" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/any-jump.vim",
    url = "https://gitcode.net/mirrors/pechorin/any-jump.vim"
  },
  ["barbar.nvim"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/barbar.nvim",
    url = "https://gitcode.net/mirrors/romgrk/barbar.nvim"
  },
  ["better-escape.nvim"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\18better_escape\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/better-escape.nvim",
    url = "https://gitcode.net/mirrors/max397574/better-escape.nvim"
  },
  ["bracey.vim"] = {
    commands = { "Bracey" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/bracey.vim",
    url = "https://gitcode.net/mirrors/turbio/bracey.vim"
  },
  ["coc.nvim"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/coc.nvim",
    url = "https://gitcode.net/mirrors/neoclide/coc.nvim"
  },
  ["codi.vim"] = {
    commands = { "Codi" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/codi.vim",
    url = "https://gitcode.net/mirrors/metakirby5/codi.vim"
  },
  ["copilot.vim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/copilot.vim",
    url = "https://gitcode.net/mirrors/github/copilot.vim"
  },
  ["diffview.nvim"] = {
    commands = { "DiffviewOpen", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rdiffview\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/diffview.nvim",
    url = "https://gitcode.net/mirrors/sindrets/diffview.nvim"
  },
  ["editorconfig-vim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/editorconfig-vim",
    url = "https://gitcode.net/mirrors/editorconfig/editorconfig-vim"
  },
  ["filetype.nvim"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/filetype.nvim",
    url = "https://gitcode.net/mirrors/nathom/filetype.nvim"
  },
  ["formatter.nvim"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/formatter.nvim",
    url = "https://gitcode.net/mirrors/mhartington/formatter.nvim"
  },
  ["git-conflict.nvim"] = {
    commands = { "GitConflictChooseOurs", "GitConflictChooseTheirs", "GitConflictChooseBoth", "GitConflictChooseNone", "GitConflictNextConflict", "GitConflictPrevConflict" },
    config = { "\27LJ\2\n:\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\17git-conflict\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/git-conflict.nvim",
    url = "https://gitcode.net/mirrors/akinsho/git-conflict.nvim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://gitcode.net/mirrors/lewis6991/gitsigns.nvim"
  },
  ["goto-preview"] = {
    config = { "\27LJ\2\n>\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\17goto-preview\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/goto-preview",
    url = "https://gitcode.net/mirrors/rmagatti/goto-preview"
  },
  ["gruvbox-material"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/gruvbox-material",
    url = "https://gitcode.net/mirrors/sainnhe/gruvbox-material"
  },
  ["hop.nvim"] = {
    commands = { "HopWord", "HopLine", "HopPattern" },
    config = { "\27LJ\2\n5\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\nsetup\bhop\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/hop.nvim",
    url = "https://gitcode.net/mirrors/phaazon/hop.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://gitcode.net/mirrors/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\nÜ\3\0\0\4\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\2B\0\2\1K\0\1\0\20buftype_exclude\1\3\0\0\rterminal\vnofile\21filetype_exculde\1\b\0\0\nalpha\vpacker\rNvimTree\16lsp-install\thelp\20TelescopePrompt\21TelescopeResults\27context_highlight_list\1\a\0\0\27IndentBlanklineIndent1\27IndentBlanklineIndent2\27IndentBlanklineIndent3\27IndentBlanklineIndent4\27IndentBlanklineIndent5\27IndentBlanklineIndent6\1\0\4\19use_treesitter\2\31show_current_context_start\2\25show_current_context\2\25space_char_blankline\6 \nsetup\21indent_blankline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://gitcode.net/mirrors/lukas-reineke/indent-blankline.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://gitcode.net/mirrors/nvim-lualine/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    commands = { "MarkdownPreview" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim",
    url = "https://gitcode.net/mirrors/iamcco/markdown-preview.nvim"
  },
  ["marks.nvim"] = {
    config = { "\27LJ\2\n·\2\0\0\4\0\f\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0024\3\0\0=\3\b\0025\3\t\0=\3\n\0024\3\0\0=\3\v\2B\0\2\1K\0\1\0\rmappings\15bookmark_0\1\0\2\14virt_text\vsterne\tsign\bâš‘\23excluded_filetypes\18sign_priority\1\0\4\fbuiltin\3\b\rbookmark\3\20\nupper\3\15\nlower\3\n\18builtin_marks\1\5\0\0\6.\6<\6>\6^\1\0\4\21refresh_interval\3ú\1\22force_write_shada\1\vcyclic\2\21default_mappings\2\nsetup\nmarks\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/marks.nvim",
    url = "https://gitcode.net/mirrors/chentau/marks.nvim"
  },
  ["move.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/move.nvim",
    url = "https://gitcode.net/mirrors/fedepujol/move.nvim"
  },
  neogen = {
    config = { "\27LJ\2\nD\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\fenabled\2\nsetup\vneogen\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/neogen",
    url = "https://gitcode.net/mirrors/danymat/neogen"
  },
  ["nightfox.nvim"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/nightfox.nvim",
    url = "https://gitcode.net/mirrors/EdenEast/nightfox.nvim"
  },
  ["numb.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\tnumb\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/numb.nvim",
    url = "https://gitcode.net/mirrors/nacro90/numb.nvim"
  },
  ["nvim-bqf"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\nsetup\bbqf\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/nvim-bqf",
    url = "https://gitcode.net/mirrors/kevinhwang91/nvim-bqf"
  },
  ["nvim-code-action-menu"] = {
    commands = { "CodeActionMenu" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/nvim-code-action-menu",
    url = "https://gitcode.net/mirrors/weilbith/nvim-code-action-menu"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://gitcode.net/mirrors/norcalli/nvim-colorizer.lua"
  },
  ["nvim-gps"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/nvim-gps",
    url = "https://gitcode.net/mirrors/SmiteshP/nvim-gps"
  },
  ["nvim-hlslens"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/nvim-hlslens",
    url = "https://gitcode.net/mirrors/kevinhwang91/nvim-hlslens"
  },
  ["nvim-notify"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://gitcode.net/mirrors/rcarriga/nvim-notify"
  },
  ["nvim-peekup"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/nvim-peekup",
    url = "https://gitcode.net/mirrors/gennaro-tedesco/nvim-peekup"
  },
  ["nvim-spectre"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fspectre\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/nvim-spectre",
    url = "https://gitcode.net/mirrors/nvim-pack/nvim-spectre"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://gitcode.net/mirrors/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://gitcode.net/mirrors/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    config = { "\27LJ\2\nD\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\23treesitter-context\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-context",
    url = "https://gitcode.net/mirrors/romgrk/nvim-treesitter-context"
  },
  ["nvim-treesitter-refactor"] = {
    config = { "\27LJ\2\nE\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\tinit\29nvim-treesitter-refactor\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-refactor",
    url = "https://gitcode.net/mirrors/nvim-treesitter/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects",
    url = "https://gitcode.net/mirrors/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-autotag"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/nvim-ts-autotag",
    url = "https://gitcode.net/mirrors/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring",
    url = "https://gitcode.net/mirrors/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-ts-rainbow"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/nvim-ts-rainbow",
    url = "https://gitcode.net/mirrors/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://gitcode.net/mirrors/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://gitcode.net/mirrors/wbthomason/packer.nvim"
  },
  playground = {
    commands = { "TSPlaygroundToggle" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/playground",
    url = "https://gitcode.net/mirrors/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://gitcode.net/mirrors/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://gitcode.net/mirrors/nvim-lua/popup.nvim"
  },
  ["project.nvim"] = {
    config = { "\27LJ\2\n>\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\17project_nvim\frequire\0" },
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/project.nvim",
    url = "https://gitcode.net/mirrors/ahmedkhalf/project.nvim"
  },
  ["reach.nvim"] = {
    config = { "\27LJ\2\nI\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\18notifications\2\nsetup\nreach\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/reach.nvim",
    url = "https://gitcode.net/mirrors/toppair/reach.nvim"
  },
  ["refactoring.nvim"] = {
    config = { "\27LJ\2\nj\0\0\3\0\5\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\4\0'\2\1\0B\0\2\1K\0\1\0\19load_extension\14telescope\nsetup\16refactoring\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/refactoring.nvim",
    url = "https://gitcode.net/mirrors/ThePrimeagen/refactoring.nvim"
  },
  ["rest.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14rest-nvim\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/rest.nvim",
    url = "https://gitcode.net/mirrors/NTBBloodbath/rest.nvim"
  },
  ["sidebar.nvim"] = {
    commands = { "SidebarNvimToggle" },
    config = { "\27LJ\2\n\31\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0À\ncloseØ\1\1\0\6\0\14\0\0186\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\5\0003\5\4\0=\5\6\4=\4\a\0035\4\b\0=\4\t\0035\4\v\0005\5\n\0=\5\f\4=\4\r\3B\1\2\0012\0\0€K\0\1\0\bdap\16breakpoints\1\0\0\1\0\1\ticon\tðŸ”\rsections\1\4\0\0\rdatetime\bgit\16diagnostics\rbindings\6q\1\0\0\0\1\0\2\18initial_width\3\30\topen\1\nsetup\17sidebar-nvim\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/sidebar.nvim",
    url = "https://gitcode.net/mirrors/sidebar-nvim/sidebar.nvim"
  },
  ["splitjoin.vim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/splitjoin.vim",
    url = "https://gitcode.net/mirrors/AndrewRadev/splitjoin.vim"
  },
  ["switch.vim"] = {
    commands = { "Switch" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/switch.vim",
    url = "https://gitcode.net/mirrors/AndrewRadev/switch.vim"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://gitcode.net/mirrors/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-packer.nvim"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/telescope-packer.nvim",
    url = "https://gitcode.net/mirrors/nvim-telescope/telescope-packer.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://gitcode.net/mirrors/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/todo-comments.nvim",
    url = "https://gitcode.net/mirrors/folke/todo-comments.nvim"
  },
  ["twilight.nvim"] = {
    commands = { "Twilight" },
    config = { "\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0B\0\2\1K\0\1\0\nsetup\rtwilight\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/twilight.nvim",
    url = "https://gitcode.net/mirrors/folke/twilight.nvim"
  },
  ["vim-be-good"] = {
    commands = { "VimBeGood" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/vim-be-good",
    url = "https://gitcode.net/mirrors/ThePrimeagen/vim-be-good"
  },
  ["vim-better-whitespace"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/vim-better-whitespace",
    url = "https://gitcode.net/mirrors/ntpeters/vim-better-whitespace"
  },
  ["vim-doge"] = {
    commands = { "DogeGenerate", "DogeCreateDocStandard" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/vim-doge",
    url = "https://gitcode.net/mirrors/kkoomen/vim-doge"
  },
  ["vim-eunuch"] = {
    commands = { "Delete", "Mkdir", "Rename" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/vim-eunuch",
    url = "https://gitcode.net/mirrors/tpope/vim-eunuch"
  },
  ["vim-flog"] = {
    commands = { "Flog" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/vim-flog",
    url = "https://gitcode.net/mirrors/rbong/vim-flog"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://gitcode.net/mirrors/tpope/vim-fugitive"
  },
  ["vim-import-cost"] = {
    commands = { "ImportCost" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/vim-import-cost",
    url = "https://gitcode.net/mirrors/yardnsm/vim-import-cost"
  },
  ["vim-nightfly-guicolors"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/vim-nightfly-guicolors",
    url = "https://gitcode.net/mirrors/bluz71/vim-nightfly-guicolors"
  },
  ["vim-repeat"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/vim-repeat",
    url = "https://gitcode.net/mirrors/tpope/vim-repeat"
  },
  ["vim-sandwich"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/vim-sandwich",
    url = "https://gitcode.net/mirrors/machakann/vim-sandwich"
  },
  ["vim-speeddating"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/vim-speeddating",
    url = "https://gitcode.net/mirrors/tpope/vim-speeddating"
  },
  ["vim-translator"] = {
    commands = { "Translate" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/vim-translator",
    url = "https://gitcode.net/mirrors/voldikss/vim-translator"
  },
  ["vim-visual-multi"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/vim-visual-multi",
    url = "https://gitcode.net/mirrors/mg979/vim-visual-multi"
  },
  ["vista.vim"] = {
    commands = { "Vista" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/opt/vista.vim",
    url = "https://gitcode.net/mirrors/liuchengxu/vista.vim"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "/Users/sternelee/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://gitcode.net/mirrors/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: project.nvim
time([[Config for project.nvim]], true)
try_loadstring("\27LJ\2\n>\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\17project_nvim\frequire\0", "config", "project.nvim")
time([[Config for project.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file GitConflictChooseBoth lua require("packer.load")({'git-conflict.nvim'}, { cmd = "GitConflictChooseBoth", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file GitConflictChooseNone lua require("packer.load")({'git-conflict.nvim'}, { cmd = "GitConflictChooseNone", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file GitConflictNextConflict lua require("packer.load")({'git-conflict.nvim'}, { cmd = "GitConflictNextConflict", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file GitConflictPrevConflict lua require("packer.load")({'git-conflict.nvim'}, { cmd = "GitConflictPrevConflict", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file MarkdownPreview lua require("packer.load")({'markdown-preview.nvim'}, { cmd = "MarkdownPreview", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Switch lua require("packer.load")({'switch.vim'}, { cmd = "Switch", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Flog lua require("packer.load")({'vim-flog'}, { cmd = "Flog", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSPlaygroundToggle lua require("packer.load")({'playground'}, { cmd = "TSPlaygroundToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file VimBeGood lua require("packer.load")({'vim-be-good'}, { cmd = "VimBeGood", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DiffviewToggleFiles lua require("packer.load")({'diffview.nvim'}, { cmd = "DiffviewToggleFiles", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DiffviewFocusFiles lua require("packer.load")({'diffview.nvim'}, { cmd = "DiffviewFocusFiles", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Rename lua require("packer.load")({'vim-eunuch'}, { cmd = "Rename", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Codi lua require("packer.load")({'codi.vim'}, { cmd = "Codi", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file ImportCost lua require("packer.load")({'vim-import-cost'}, { cmd = "ImportCost", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Bracey lua require("packer.load")({'bracey.vim'}, { cmd = "Bracey", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SidebarNvimToggle lua require("packer.load")({'sidebar.nvim'}, { cmd = "SidebarNvimToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file CodeActionMenu lua require("packer.load")({'nvim-code-action-menu'}, { cmd = "CodeActionMenu", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DiffviewOpen lua require("packer.load")({'diffview.nvim'}, { cmd = "DiffviewOpen", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Vista lua require("packer.load")({'vista.vim'}, { cmd = "Vista", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DogeGenerate lua require("packer.load")({'vim-doge'}, { cmd = "DogeGenerate", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DogeCreateDocStandard lua require("packer.load")({'vim-doge'}, { cmd = "DogeCreateDocStandard", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Mkdir lua require("packer.load")({'vim-eunuch'}, { cmd = "Mkdir", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Delete lua require("packer.load")({'vim-eunuch'}, { cmd = "Delete", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file AnyJump lua require("packer.load")({'any-jump.vim'}, { cmd = "AnyJump", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Translate lua require("packer.load")({'vim-translator'}, { cmd = "Translate", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Twilight lua require("packer.load")({'twilight.nvim'}, { cmd = "Twilight", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file HopWord lua require("packer.load")({'hop.nvim'}, { cmd = "HopWord", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file HopLine lua require("packer.load")({'hop.nvim'}, { cmd = "HopLine", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file HopPattern lua require("packer.load")({'hop.nvim'}, { cmd = "HopPattern", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file GitConflictChooseOurs lua require("packer.load")({'git-conflict.nvim'}, { cmd = "GitConflictChooseOurs", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file GitConflictChooseTheirs lua require("packer.load")({'git-conflict.nvim'}, { cmd = "GitConflictChooseTheirs", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType http ++once lua require("packer.load")({'rest.nvim'}, { ft = "http" }, _G.packer_plugins)]]
vim.cmd [[au FileType qf ++once lua require("packer.load")({'nvim-bqf'}, { ft = "qf" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'markdown-preview.nvim'}, { ft = "markdown" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'neogen', 'nvim-treesitter-refactor', 'nvim-spectre', 'vim-repeat', 'vim-visual-multi', 'nvim-peekup', 'nvim-ts-autotag', 'vim-sandwich', 'nvim-treesitter-textobjects', 'better-escape.nvim'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'switch.vim', 'splitjoin.vim', 'numb.nvim', 'nvim-hlslens', 'nvim-ts-rainbow', 'editorconfig-vim', 'reach.nvim', 'nvim-bqf', 'refactoring.nvim', 'indent-blankline.nvim', 'marks.nvim', 'vim-speeddating', 'move.nvim', 'copilot.vim', 'nvim-treesitter-context'}, { event = "BufRead *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/sternelee/.local/share/nvim/site/pack/packer/opt/rest.nvim/ftdetect/http.vim]], true)
vim.cmd [[source /Users/sternelee/.local/share/nvim/site/pack/packer/opt/rest.nvim/ftdetect/http.vim]]
time([[Sourcing ftdetect script at: /Users/sternelee/.local/share/nvim/site/pack/packer/opt/rest.nvim/ftdetect/http.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles(1) end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
