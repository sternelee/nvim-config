local ok, _ = pcall(require, 'impatient')
if ok then
  -- require('impatient') -- 必须是第一加载
  require('impatient').enable_profile()
end
local cmd = vim.cmd
local g = vim.g
local fn = vim.fn
local execute = vim.api.nvim_command
local nvim_exec = vim.api.nvim_exec
local remap = vim.api.nvim_set_keymap
local keymap = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local autogroup = vim.api.nvim_create_augroup
-- local usercmd = vim.api.nvim_create_user_command

g.loaded_python_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0

nvim_exec([[set guifont=VictorMono\ NF:h16]], false)

--set shortmess
vim.o.shortmess = vim.o.shortmess .. "c"

vim.o.sessionoptions="buffers,help,tabpages"
vim.opt.fillchars:append('fold:•')

nvim_exec([[
filetype plugin on
filetype indent on
]], false)

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
end

-- https://github.com/rockerBOO/awesome-neovim
-- https://github.com/glepnir/nvim-lua-guide-zh
-- https://github.com/neovim/neovim/wiki/Related-projects#Plugins
-- using :source % or :luafile %
-- log: nvim -V9myNvim.log
cmd [[packadd packer.nvim]]
local packer = require('packer')
packer.startup({function()
  use 'wbthomason/packer.nvim'
  use {'lewis6991/impatient.nvim'}
  use 'nathom/filetype.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use {'antoinemadec/FixCursorHold.nvim', opt = true, event = 'BufRead'}
  -- 状态栏
  use 'romgrk/barbar.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-lualine/lualine.nvim'
  use {'kyazdani42/nvim-tree.lua', opt = true, cmd = 'NvimTreeToggle',
    config = function()
      require'modules.nvim-tree'
    end
  }
  use 'goolord/alpha-nvim'
  -- git相关
  use 'tpope/vim-fugitive'
  use {'kdheepak/lazygit.nvim', opt = true, cmd = {'LazyGit', 'LazyGitConfig', 'LazyGitFilter', 'LazyGitFilterCurrentFile'}}
  use {'akinsho/git-conflict.nvim', opt = true, cmd = {'GitConflictChooseOurs', 'GitConflictChooseTheirs', 'GitConflictChooseBoth', 'GitConflictChooseNone', 'GitConflictNextConflict', 'GitConflictPrevConflict'}, config = function()
    require('git-conflict').setup()
  end}
  use {'rbong/vim-flog', opt = true, cmd = {'Flog'}}
  use {'sindrets/diffview.nvim', opt = true, cmd = {'DiffviewOpen', 'DiffviewToggleFiles', 'DiffviewFocusFiles'},
    config = function ()
      require('diffview').setup()
    end
  }
  -- 语法高亮
  use { 'kevinhwang91/nvim-treesitter', run = ':TSUpdate' }
  use {'nvim-treesitter/nvim-treesitter-textobjects', opt = true, event = 'InsertEnter'}
  use {'folke/twilight.nvim', opt = true, cmd = {'Twilight'}, config = function() require('twilight'):setup() end}
  use 'NvChad/nvim-colorizer.lua' -- 色值高亮
  -- theme 主题 -- https://vimcolorschemes.com/
  use 'RRethy/nvim-base16'
  use {'Mofiqul/vscode.nvim', 'LunarVim/synthwave84.nvim'}
  use {'katawful/kat.nvim', tag = '1.0'}
  -- 显示导航线
  use {'lukas-reineke/indent-blankline.nvim', event = 'BufRead',
    config = function()
      require("indent_blankline").setup {
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
        use_treesitter = true,
        context_highlight_list = {
          'IndentBlanklineIndent1',
          'IndentBlanklineIndent2',
          'IndentBlanklineIndent3',
          'IndentBlanklineIndent4',
          'IndentBlanklineIndent5',
          'IndentBlanklineIndent6',
        },
        filetype_exculde = {
          'alpha',
          'packer',
          'NvimTree',
          'lsp-install',
          'help',
          'TelescopePrompt',
          'TelescopeResults',
        },
        buftype_exclude = { 'terminal', 'nofile' },
      }
    end}
  use {'mg979/vim-visual-multi', opt = true, event = 'InsertEnter'}
  use {'terryma/vim-expand-region', opt = true, event = 'BufRead'}
  use {'phaazon/hop.nvim', opt = true, cmd = {'HopWord', 'HopLine', 'HopPattern'}, config = function() require('hop'):setup() end}
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use {
    'ahmedkhalf/project.nvim',
    config = function()
      require'project_nvim'.setup{}
    end
  }
  -- 语法建议
  use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile'}
  use {
    'weilbith/nvim-code-action-menu',
    after = 'coc.nvim',
    requires = 'xiyaowong/coc-code-action-menu.nvim',
    opt = true,
    cmd = 'CodeActionMenu',
    config = function()
      require 'coc-code-action-menu'
    end,
  }
  -- 语法提示
  use {'liuchengxu/vista.vim', opt = true, cmd = {'Vista'}}
  use {'editorconfig/editorconfig-vim', opt = true, event = 'BufRead'}
  use {'kevinhwang91/nvim-bqf', ft = 'qf', event = 'BufRead', config = function() require('bqf'):setup() end}
  -- 方便操作
  use {'iamcco/markdown-preview.nvim', opt = true, ft = 'markdown', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}
  use {'nacro90/numb.nvim', opt = true, event = 'BufRead', config = function()
    require('numb').setup()
  end}
  use {'voldikss/vim-translator', opt = true, cmd = {'Translate'}} -- npm install fanyi -g 安装翻译
  use {'tpope/vim-commentary', opt = true, event = 'BufRead'}
  use {'machakann/vim-sandwich', opt = true, event = 'InsertEnter'}
  use {'chentoast/marks.nvim', opt = true, event = 'BufRead',
    config = function ()
      require('marks').setup({
        default_mappings = true,
        builtin_marks = { ".", "<", ">", "^" },
        cyclic = true,
        force_write_shada = false,
        refresh_interval = 250,
        sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
        excluded_filetypes = {},
        bookmark_0 = {
          sign = "⚑",
          virt_text = "sterne"
        },
        mappings = {}
      })
    end}
  use 'folke/which-key.nvim' -- 提示leader按键
  -- use {'anuvyklack/hydra.nvim', requires = 'anuvyklack/keymap-layer.nvim', config = function () require('modules.hydra') end} -- 增强的重复操作
  use {'folke/todo-comments.nvim', opt = true, event = 'InsertEnter',
    config = function ()
      require'modules.todo'
    end
  }
  use {'ntpeters/vim-better-whitespace', opt = true, event = 'BufRead'}
  use {'ThePrimeagen/vim-be-good', opt = true, cmd = 'VimBeGood'}
  use {'mhartington/formatter.nvim', opt = true, cmd = 'Format',
    config = function()
      require'modules.formatter'
    end
  }
  use 'rcarriga/nvim-notify'
  use {'metakirby5/codi.vim', opt = true, cmd = {'Codi'}}
  use {'nvim-pack/nvim-spectre',
    opt = true,
    event = 'InsertEnter',
    config = function()
      require('spectre').setup()
    end
  }
  use {'tpope/vim-repeat', opt = true, event = 'InsertEnter'}
  use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async',
    config = function()
      require'modules.ufo'
  end}
  use {"wakatime/vim-wakatime", opt = true, event = "BufRead"}

end,
config = {
  profile = {
    enabled = true,
    threshold = 1
  }
}})

--settings
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

local indent = 2
opt('b', 'expandtab', true)                           -- Use spaces instead of tabs
opt('b', 'shiftwidth', indent)                        -- Size of an indent
opt('b', 'smartindent', true)                         -- Insert indents automatically
opt('b', 'tabstop', indent)                           -- Number of spaces tabs count for
opt('o', 'completeopt', 'menu,menuone,noselect')      -- Completion options
opt('o', 'hidden', true)                              -- Enable modified buffers in background
opt('o', 'scrolloff', 3)                              -- Lines of context
opt('o', 'shiftround', true)                          -- Round indent
opt('o', 'sidescrolloff', 8)                          -- Columns of context
opt('o', 'smartcase', true)                           -- Don't ignore case with capitals
opt('o', 'splitbelow', true)                          -- Put new windows below current
opt('o', 'splitright', true)                          -- Put new windows right of current
opt('o', 'termguicolors', true)                       -- True color support
opt('o', 'clipboard', 'unnamedplus')                      -- 与系统剪切板相通
opt('o', 'pumblend', 25 )
opt('o', 'softtabstop', 2)
opt('o', 'swapfile', false)
opt('o', 'showmode', false)
opt('o', 'background', 'dark')
opt('o', 'backup', false)
opt('o', 'writebackup', false)
opt('w', 'number', true)                              -- Print line number
opt('o', 'lazyredraw', true)
opt('o', 'signcolumn', 'yes')
opt('o', 'mouse', 'a')
opt('o', 'cmdheight', 1)
opt('o', 'wrap', false)
opt('o', 'relativenumber', true)
opt('o', 'hlsearch', true)
opt('o', 'inccommand', 'split')
opt('o', 'smarttab', true)
opt('o', 'incsearch', true)
opt('o', 'foldmethod', 'indent')
-- opt('o', 'foldcolumn', '1')
opt('o', 'foldenable', true)
opt('o', 'foldlevel', 99)
opt('o', 'foldlevelstart', 99)
opt('o', 'breakindent', true)
opt('o', 'lbr', true)
opt('o', 'formatoptions', 'l')
opt('o', 'laststatus', 3)
opt('o', 'cursorline', true)
opt('o', 'cursorcolumn', true)
opt('o', 'autowrite', true)
opt('o', 'autoindent', true)
opt('o', 'syntax', 'on')
opt('o', 'filetype', 'on')
opt('o', 'timeoutlen', 500)
opt('o', 'history', 500)
opt('o', 'ttimeoutlen', 10)
opt('o', 'updatetime', 300)
opt('o', 'writebackup', false)
opt('o', 'scrolljump', 6)
opt('o', 'undofile', true)
opt('o', 'showtabline', 0)

--mappings
local function map(mode, lhs, rhs)
  local options = {noremap = true}
  remap(mode, lhs, rhs, options)
end

-- g.do_filetype_lua = 1 -- nvim > 0.7
-- g.did_load_filetypes = 0
g.mapleader = " "                                                     --leader
g.maplocalleader = ","
map('v', 'P', '"0p')
map('i', 'jk', '<esc>')                                               --jk to exit
map('c', 'jk', '<C-C>')
map('n', ';f', '<C-f>')
map('n', ';b', '<C-b>')
map('n', ';', ':')                                                     --semicolon to enter command mode
map('n', 'j', 'gj')                                                    --move by visual line not actual line
map('n', 'k', 'gk')
map('n', 'q', '<cmd>q<CR>')
map('n', 'gw', '<cmd>HopWord<CR>')                              --easymotion/hop
map('n', 'gl', '<cmd>HopLine<CR>')
map('n', 'g/', '<cmd>HopPattern<CR>')
map('n', '<leader>:', '<cmd>terminal<CR>')
map('n', '<leader>*', '<cmd>Telescope<CR>')                   --fuzzy
map('n', '<leader>f', '<cmd>Telescope find_files<CR>')
map('n', '<leader>b', '<cmd>Telescope buffers<CR>')
map('n', '<leader>m', '<cmd>Telescope marks<CR>')
map('n', '<leader>/', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>\'', '<cmd>Telescope resume<CR>')
map('n', '<leader>s', '<cmd>Telescope grep_string<CR>')
map('n', '<leader>p', '<cmd>Telescope commands<CR>')
map('n', 'fc', '<cmd>Telescope commands<CR>')
map('n', 'fe', '<cmd>Telescope file_browser<CR>')
map('n', 'fp', '<cmd>Telescope projects<CR>')
map('n', 'fg', '<cmd>Telescope git_files<CR>')
map('n', 'fc', '<cmd>Telescope commands<CR>')
map('n', 'fe', '<cmd>Telescope file_browser<CR>')
map('n', 'fp', '<cmd>Telescope projects<CR>')
map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>')
map('n', 'tr', '<cmd>NvimTreeRefresh<CR>')
map('n', 'tl', '<cmd>Twilight<CR>')
map('n', 'tw', '<cmd>Translate<CR>')
map('n', '<leader>sl', '<cmd>SessionLoad<CR>')
map('n', '<leader>ss', '<cmd>SessionSave<CR>')
map('n', '<leader>tv', '<cmd>DocsViewToggle<CR>')
map('n', '<leader>td', '<cmd>DiffviewOpen<CR>')
map('n', '<leader>tD', '<cmd>DiffviewClose<CR>')
map('n', '<c-k>', '<cmd>wincmd k<CR>')                                 --ctrlhjkl to navigate splits
map('n', '<c-j>', '<cmd>wincmd j<CR>')
map('n', '<c-h>', '<cmd>wincmd h<CR>')
map('n', '<c-l>', '<cmd>wincmd l<CR>')
map('n', '<c-s>', '<cmd>w<CR>')
map('n', '<s-q>', '<cmd>BufferClose<CR>')
map('n', '<Tab>', '<cmd>BufferNext<CR>')
map('n', '<s-Tab>', '<cmd>BufferPrevious<CR>')
-- map('n', 'gb', '<cmd>BufferPick<CR>')
-- map('n', 'gp', '<cmd>bprevious<CR>')
map('n', 'gn', '<cmd>bnext<CR>')
map('n', '<leader>be', '<cmd>tabedit<CR>')
map('n', '<leader>ga', '<cmd>Git add %:p<CR>')
map('n', '<leader>go', '<cmd>Git add .<CR>')
map('n', '<leader>gm', '<cmd>Git commit<CR>')
map('n', '<leader>gs', '<cmd>Git status<CR>')
map('n', '<leader>gl', '<cmd>Git pull<CR>')
map('n', '<leader>gu', '<cmd>Git push<CR>')
map('n', '<leader>gr', '<cmd>Git reset --hard<CR>')
-- map('n', '<leader>gl', '<cmd>Git log<CR>')
map('n', '<leader><leader>i', '<cmd>PackerInstall<CR>')
map('n', '<leader><leader>u', '<cmd>PackerUpdate<CR>')

map('n', '<leader>j', '<cmd>AnyJump<CR>')
map('v', '<leader>j', '<cmd>AnyJumpVisual<CR>')
map('n', '<leader>ab', '<cmd>AnyJumpBack<CR>')
map('n', '<leader>al', '<cmd>AnyJumpLastResults<CR>')

-- spectre
map('n', '<leader>S', '<cmd>lua require("spectre").open()<CR>')
map('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>')
map('v', '<leader>s', '<cmd>lua require("spectre").open_visual()<CR>')
map('n', '<leader>sp', 'viw:lua require("spectre").open_file_search()<cr>')

-- ufo
map('n', 'zR', '<cmd>lua require("ufo").openAllFolds()<CR>')
map('n', 'zM', '<cmd>lua require("ufo").closeAllFolds()<CR>')

-- coc-code-action-menu
map('n', 'gam', '<cmd>CodeActionMenu<CR>')

cmd [[autocmd BufWritePre * %s/\s\+$//e]]                             --remove trailing whitespaces
cmd [[autocmd BufWritePre * %s/\n\+\%$//e]]

autocmd({ "TextYankPost" }, {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higrou = "IncSearch", timeout = 500 })
    end,
    desc = "Highlight yanked text",
    group = autogroup("highlight_yank", { clear = true }),
})

local numbers = {"1", "2", "3", "4", "5", "6", "7", "8", "9"}
for _, num in pairs(numbers) do
  map('n', '<leader>'..num, '<cmd>BufferGoto '..num..'<CR>')
end
map('n', '<leader>0', '<cmd>BufferGoto 10<CR>')

--barbar
nvim_exec([[
let bufferline = get(g:, 'bufferline', {})
let bufferline.animation = v:false
let bufferline.auto_hide = v:true
let bufferline.icons = 'both'
]], false)

g.vista_default_executive = 'coc'
g.markdown_fenced_language = {
  "ts=typescript"
}

--theme
cmd 'colorscheme kat.nwim'

-- editorconfig-vim
g.EditorConfig_exclude_patterns = {'fugitive://.*', 'scp://.*', ''}

-- vim-better-whitespace
g.better_whitespace_filetypes_blacklist ={'diff', 'git', 'qf', 'help', 'fugitive', 'minimap'}

local notify = require("notify")
notify.setup{
  background_colour = '#1e1e1e'
}
vim.notify = notify

require'modules.telescope'
require'modules.treesitter'

local startify = require('alpha.themes.startify')
local header = {
   '┍━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┑',
   '│ ⣇⣿⠘⣿⣿⣿⡿⡿⣟⣟⢟⢟⢝⠵⡝⣿⡿⢂⣼⣿⣷⣌⠩⡫⡻⣝⠹⢿⣿⣷ │',
   '│ ⡆⣿⣆⠱⣝⡵⣝⢅⠙⣿⢕⢕⢕⢕⢝⣥⢒⠅⣿⣿⣿⡿⣳⣌⠪⡪⣡⢑⢝⣇ │',
   '│ ⡆⣿⣿⣦⠹⣳⣳⣕⢅⠈⢗⢕⢕⢕⢕⢕⢈⢆⠟⠋⠉⠁⠉⠉⠁⠈⠼⢐⢕⢽ │',
   '│ ⡗⢰⣶⣶⣦⣝⢝⢕⢕⠅⡆⢕⢕⢕⢕⢕⣴⠏⣠⡶⠛⡉⡉⡛⢶⣦⡀⠐⣕⢕ │',
   '│ ⡝⡄⢻⢟⣿⣿⣷⣕⣕⣅⣿⣔⣕⣵⣵⣿⣿⢠⣿⢠⣮⡈⣌⠨⠅⠹⣷⡀⢱⢕ │',
   '│ ⡝⡵⠟⠈⢀⣀⣀⡀⠉⢿⣿⣿⣿⣿⣿⣿⣿⣼⣿⢈⡋⠴⢿⡟⣡⡇⣿⡇⡀⢕ │',
   '│ ⡝⠁⣠⣾⠟⡉⡉⡉⠻⣦⣻⣿⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣦⣥⣿⡇⡿⣰⢗⢄ │',
   '│ ⠁⢰⣿⡏⣴⣌⠈⣌⠡⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⣉⣉⣁⣄⢖⢕⢕⢕ │',
   '│ ⡀⢻⣿⡇⢙⠁⠴⢿⡟⣡⡆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣵⣵⣿ │',
   '│ ⡻⣄⣻⣿⣌⠘⢿⣷⣥⣿⠇⣿⣿⣿⣿⣿⣿⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿ │',
   '│ ⣷⢄⠻⣿⣟⠿⠦⠍⠉⣡⣾⣿⣿⣿⣿⣿⣿⢸⣿⣦⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟ │',
   '│ ⡕⡑⣑⣈⣻⢗⢟⢞⢝⣻⣿⣿⣿⣿⣿⣿⣿⠸⣿⠿⠃⣿⣿⣿⣿⣿⣿⡿⠁⣠ │',
   '│ ⡝⡵⡈⢟⢕⢕⢕⢕⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⣀⣈⠙ │',
   '│ ⡝⡵⡕⡀⠑⠳⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⢉⡠⡲⡫⡪⡪⡣ │',
   '┕━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┙',
}

-- 布局
startify.section.header.val = header
-- 高亮
-- startify.section.header.opts.hl = 'AlphaHeader'

require'alpha'.setup(startify.opts)

require'which-key'.setup{}
require'colorizer'.setup{
  filetypes = { "*" },
  user_default_options = {
    rgb_fn = true,
    hsl_fn = true,
    css = true,
    css_fn = true,
  }
}

require'modules.lualine'

cmd([[ let @r="\y:%s/\<C-r>\"//g\<Left>\<Left>" ]])
cmd([[ let @h=":ProjectRoot \<CR> :w\<CR> :vsp | terminal  go run *.go \<CR>i" ]])
cmd([[ let @1=":call CppComp() \<CR>G:66\<CR>" ]])
cmd([[ let @c=":cd %:h \<CR>" ]])
-- 按 @g 运行代码
-- All previous macros have been changed to autocmd, @g macro will run current file
cmd [[
	augroup run_file
		autocmd BufEnter *.java let @g=":w\<CR>:vsp | terminal java %\<CR>i"
		autocmd BufEnter *.py let @g=":w\<CR>:vsp |terminal python %\<CR>i"
		autocmd BufEnter *.asm let @g=":w\<CR> :!nasm -f elf64 -o out.o % && ld out.o -o a.out \<CR> | :vsp |terminal ./a.out\<CR>i"
		autocmd BufEnter *.cpp let @g=":w\<CR> :!g++ %\<CR> | :vsp |terminal ./a.out\<CR>i"
		autocmd BufEnter *.c let @g=":w\<CR> :!gcc %\<CR> | :vsp |terminal ./a.out\<CR>i"
		autocmd BufEnter *.go let @g=":w\<CR> :vsp | terminal go run % \<CR>i"
		autocmd BufEnter *.js let @g=":w\<CR> :vsp | terminal node % \<CR>i"
		autocmd BufEnter *.html let @g=":w\<CR> :silent !chromium % \<CR>"
	augroup end
]]

cmd [[
  highlight IndentBlanklineIndent1 guifg=#E06C75
  highlight IndentBlanklineIndent2 guifg=#E5C07B
  highlight IndentBlanklineIndent3 guifg=#98C379
  highlight IndentBlanklineIndent4 guifg=#56B6C2
  highlight IndentBlanklineIndent5 guifg=#61AFEF
  highlight IndentBlanklineIndent6 guifg=#C678DD
  highlight Normal ctermbg=NONE guibg=NONE
]]
-- coc
g.coc_global_extensions = {
   'coc-git',
   'coc-html',
   'coc-lists',
   'coc-marketplace',
   'coc-tsserver',
   'coc-json',
   'coc-css',
   'coc-emmet',
   'coc-gitignore',
   'coc-toml',
   'coc-lightbulb',
   'coc-highlight',
   'coc-pairs',
   'coc-htmlhint',
   'coc-yank',
   'coc-translator',
   'coc-markdownlint',
   'coc-symbol-line',
   '@yaegassy/coc-tailwindcss3'
}

g.coc_start_at_startup=0
g.coc_default_semantic_highlight_groups = 1
g.coc_enable_locationlist = 0
g.coc_selectmode_mapping = 0

-- cmd [[ source ~/AppData/Local/nvim/config.vim ]]
cmd [[ source ~/.config/nvim/config.vim ]]

remap("n", "gd", "<Plug>(coc-definition)", {silent = true})
remap("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
remap("n", "gi", "<Plug>(coc-implementation)", {silent = true})
remap("n", "gh", "<Plug>(coc-references)", {silent = true})
remap("n", "<leader>ca", "<Plug>(coc-codeaction)", {})
remap("n", "<leader>ef", ":CocCommand eslint.executeAutofix<CR>", {})
remap("n", "K", ":call CocActionAsync('doHover')<CR>", {silent = true, noremap = true})
remap("n", "[d", "<Plug>(coc-diagnostic-prev)", {silent = true})
remap("n", "]d", "<Plug>(coc-diagnostic-next)", {silent = true})
remap("n", "gr", "<Plug>(coc-rename)", {})
remap("i", "<C-Space>", "coc#refresh()", { silent = true, expr = true })

-- 使用notify显示coc信息
local coc_status_record = {}

function coc_status_notify(msg, level)
  local notify_opts = { title = "LSP Status", timeout = 200, hide_from_history = true, on_close = reset_coc_status_record }
  -- if coc_status_record is not {} then add it to notify_opts to key called "replace"
  if coc_status_record ~= {} then
    notify_opts["replace"] = coc_status_record.id
  end
  coc_status_record = vim.notify(msg, level, notify_opts)
end

function reset_coc_status_record(window)
  coc_status_record = {}
end

local coc_diag_record = {}

function coc_diag_notify(msg, level)
  local notify_opts = { title = "LSP Diagnostics", timeout = 200, on_close = reset_coc_diag_record }
  -- if coc_diag_record is not {} then add it to notify_opts to key called "replace"
  if coc_diag_record ~= {} then
    notify_opts["replace"] = coc_diag_record.id
  end
  coc_diag_record = vim.notify(msg, level, notify_opts)
end

function reset_coc_diag_record(window)
  coc_diag_record = {}
end

-- coc-winbar by coc-symbol-line
function _G.symbol_line()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
  local ok, line = pcall(vim.api.nvim_buf_get_var, bufnr, 'coc_symbol_line')
  return ok and '%#CocSymbolLine# ' .. line or ''
end

if fn.exists '&winbar' then
  autocmd({'CursorHold', 'WinEnter', 'BufWinEnter'}, {
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
