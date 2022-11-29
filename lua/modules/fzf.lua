local actions = require "fzf-lua.actions"
require'fzf-lua'.setup {
  global_resume      = true,            -- enable global `resume`?
  global_resume_query = true,           -- include typed query in `resume`?
  winopts = {
    height           = 0.85,            -- window height
    width            = 0.80,            -- window width
    row              = 0.35,            -- window row position (0=top, 1=bottom)
    col              = 0.50,            -- window col position (0=left, 1=right)
    border           = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    fullscreen       = false,           -- start fullscreen?
    preview = {
      default        = 'builtin',           -- override the default previewer?
      border         = 'border',        -- border|noborder, applies only to
      wrap           = 'nowrap',        -- wrap|nowrap
      hidden         = 'nohidden',      -- hidden|nohidden
      vertical       = 'down:45%',      -- up|down:size
      horizontal     = 'right:60%',     -- right|left:size
      layout         = 'flex',          -- horizontal|vertical|flex
      flip_columns   = 120,             -- #cols to switch to horizontal on flex
      title          = true,            -- preview border title (file/buf)?
      title_align    = "left",          -- left|center|right, title alignment
      scrollbar      = 'float',         -- `false` or string:'float|border'
      scrolloff      = '-2',            -- float scrollbar offset from right
      scrollchars    = {'█', '' },      -- scrollbar chars ({ <full>, <empty> }
      delay          = 100,             -- delay(ms) displaying the preview
      winopts = {                       -- builtin previewer window options
        number            = true,
        relativenumber    = false,
        cursorline        = true,
        cursorlineopt     = 'both',
        cursorcolumn      = false,
        signcolumn        = 'no',
        list              = false,
        foldenable        = false,
        foldmethod        = 'manual',
      },
    },
  },
  keymap = {
    builtin = {
      -- neovim `:tmap` mappings for the fzf win
      ["<F1>"]        = "toggle-help",
      ["<F2>"]        = "toggle-fullscreen",
      -- Only valid with the 'builtin' previewer
      ["<F3>"]        = "toggle-preview-wrap",
      ["<F4>"]        = "toggle-preview",
      -- Rotate preview clockwise/counter-clockwise
      ["<F5>"]        = "toggle-preview-ccw",
      ["<F6>"]        = "toggle-preview-cw",
      ["<S-down>"]    = "preview-page-down",
      ["<S-up>"]      = "preview-page-up",
      ["<S-left>"]    = "preview-page-reset",
    },
    fzf = {
      -- fzf '--bind=' options
      ["ctrl-z"]      = "abort",
      ["ctrl-u"]      = "unix-line-discard",
      ["ctrl-f"]      = "half-page-down",
      ["ctrl-b"]      = "half-page-up",
      ["ctrl-a"]      = "beginning-of-line",
      ["ctrl-e"]      = "end-of-line",
      ["alt-a"]       = "toggle-all",
      -- Only valid with fzf previewers (bat/cat/git/etc)
      ["f3"]          = "toggle-preview-wrap",
      ["f4"]          = "toggle-preview",
      ["shift-down"]  = "preview-page-down",
      ["shift-up"]    = "preview-page-up",
    },
  },
  actions = {
    files = {
      ["default"]     = actions.file_edit_or_qf,
      ["ctrl-s"]      = actions.file_split,
      ["ctrl-v"]      = actions.file_vsplit,
      ["ctrl-t"]      = actions.file_tabedit,
      ["alt-q"]       = actions.file_sel_to_qf,
      ["alt-l"]       = actions.file_sel_to_ll,
    },
    buffers = {
      ["default"]     = actions.buf_edit,
      ["ctrl-s"]      = actions.buf_split,
      ["ctrl-v"]      = actions.buf_vsplit,
      ["ctrl-t"]      = actions.buf_tabedit,
    }
  },
  fzf_opts = {
    ['--ansi']        = '',
    ['--info']        = 'inline',
    ['--height']      = '100%',
    ['--layout']      = 'reverse',
    ['--border']      = 'none',
  },
  previewers = {
    cat = {
      cmd             = "cat",
      args            = "--number",
    },
    bat = {
      cmd             = "bat",
      args            = "--style=numbers,changes --color always",
      theme           = 'Coldark-Dark', -- bat preview theme (bat --list-themes)
      config          = nil,            -- nil uses $BAT_CONFIG_PATH
    },
    head = {
      cmd             = "head",
      args            = nil,
    },
    git_diff = {
      cmd_deleted     = "git diff --color HEAD --",
      cmd_modified    = "git diff --color HEAD",
      cmd_untracked   = "git diff --color --no-index /dev/null",
    },
    man = {
      -- NOTE: remove the `-c` flag when using man-db
      cmd             = "man -c %s | col -bx",
    },
    builtin = {
      syntax          = true,         -- preview syntax highlight?
      syntax_limit_l  = 0,            -- syntax limit (lines), 0=nolimit
      syntax_limit_b  = 1024*1024,    -- syntax limit (bytes), 0=nolimit
      limit_b         = 1024*1024*10, -- preview limit (bytes), 0=nolimit
      extensions      = {
        ["png"]       = { "viu", "-b" },
        ["jpg"]       = { "ueberzug" },
      },
      ueberzug_scaler = "cover",
    },
  },
  files = {
    -- previewer      = "bat",          -- uncomment to override previewer
                                        -- (name from 'previewers' table)
                                        -- set to 'false' to disable
    prompt            = 'Files❯ ',
    multiprocess      = true,           -- run command in a separate process
    git_icons         = true,           -- show git icons?
    file_icons        = true,           -- show file icons?
    color_icons       = true,           -- colorize file|git icons
    find_opts         = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
    rg_opts           = "--color=never --files --hidden --follow -g '!.git'",
    fd_opts           = "--color=never --type f --hidden --follow --exclude .git",
    actions = {
      ["default"]     = actions.file_edit,
      ["ctrl-y"]      = function(selected) print(selected[1]) end,
    }
  },
  git = {
    files = {
      prompt        = 'GitFiles❯ ',
      cmd           = 'git ls-files --exclude-standard',
      multiprocess  = true,           -- run command in a separate process
      git_icons     = true,           -- show git icons?
      file_icons    = true,           -- show file icons?
      color_icons   = true,           -- colorize file|git icons
      -- force display the cwd header line regardles of your current working
      -- directory can also be used to hide the header when not wanted
      -- show_cwd_header = true
    },
    status = {
      prompt        = 'GitStatus❯ ',
      -- consider using `git status -su` if you wish to see
      -- untracked files individually under their subfolders
      cmd           = "git status -s",
      file_icons    = true,
      git_icons     = true,
      color_icons   = true,
      previewer     = "git_diff",
      -- uncomment if you wish to use git-delta as pager
      --preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
      actions = {
        -- actions inherit from 'actions.files' and merge
        ["right"]   = { actions.git_unstage, actions.resume },
        ["left"]    = { actions.git_stage, actions.resume },
      },
    },
    commits = {
      prompt        = 'Commits❯ ',
      cmd           = "git log --color --pretty=format:'%C(yellow)%h%Creset %Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset'",
      preview       = "git show --pretty='%Cred%H%n%Cblue%an <%ae>%n%C(yellow)%cD%n%Cgreen%s' --color {1}",
      -- uncomment if you wish to use git-delta as pager
      --preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
      actions = {
        ["default"] = actions.git_checkout,
      },
    },
    bcommits = {
      prompt        = 'BCommits❯ ',
      cmd           = "git log --color --pretty=format:'%C(yellow)%h%Creset %Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset' <file>",
      preview       = "git diff --color {1}~1 {1} -- <file>",
      actions = {
        ["default"] = actions.git_buf_edit,
        ["ctrl-s"]  = actions.git_buf_split,
        ["ctrl-v"]  = actions.git_buf_vsplit,
        ["ctrl-t"]  = actions.git_buf_tabedit,
      },
    },
    branches = {
      prompt          = 'Branches❯ ',
      cmd             = "git branch --all --color",
      preview         = "git log --graph --pretty=oneline --abbrev-commit --color {1}",
      actions = {
        ["default"] = actions.git_switch,
      },
    },
    stash = {
      prompt          = 'Stash> ',
      cmd             = "git --no-pager stash list",
      preview         = "git --no-pager stash show --patch --color {1}",
      actions = {
        ["default"]   = actions.git_stash_apply,
        ["ctrl-x"]    = { actions.git_stash_drop, actions.resume },
      },
      fzf_opts = {
        ["--no-multi"]  = '',
        ['--delimiter'] = "'[:]'",
      },
    },
    icons = {
      ["M"]           = { icon = "M", color = "yellow" },
      ["D"]           = { icon = "D", color = "red" },
      ["A"]           = { icon = "A", color = "green" },
      ["R"]           = { icon = "R", color = "yellow" },
      ["C"]           = { icon = "C", color = "yellow" },
      ["T"]           = { icon = "T", color = "magenta" },
      ["?"]           = { icon = "?", color = "magenta" },
      -- override git icons?
      -- ["M"]        = { icon = "★", color = "red" },
      -- ["D"]        = { icon = "✗", color = "red" },
      -- ["A"]        = { icon = "+", color = "green" },
    },
  },
  grep = {
    prompt            = 'Rg❯ ',
    input_prompt      = 'Grep For❯ ',
    multiprocess      = true,           -- run command in a separate process
    git_icons         = true,           -- show git icons?
    file_icons        = true,           -- show file icons?
    color_icons       = true,           -- colorize file|git icons
    grep_opts         = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp",
    rg_opts           = "--column --line-number --no-heading --color=always --smart-case --max-columns=512",
    rg_glob           = false,        -- default to glob parsing?
    glob_flag         = "--iglob",    -- for case sensitive globs use '--glob'
    glob_separator    = "%s%-%-",     -- query separator pattern (lua): ' --'
    actions = {
      ["ctrl-g"]      = { actions.grep_lgrep }
    },
    no_header             = false,    -- hide grep|cwd header?
    no_header_i           = false,    -- hide interactive header?
  },
  args = {
    prompt            = 'Args❯ ',
    files_only        = true,
    actions           = { ["ctrl-x"] = { actions.arg_del, actions.resume } }
  },
  oldfiles = {
    prompt            = 'History❯ ',
    cwd_only          = false,
    stat_file         = true,         -- verify files exist on disk
    include_current_session = false,  -- include bufs from current session
  },
  buffers = {
    prompt            = 'Buffers❯ ',
    file_icons        = true,         -- show file icons?
    color_icons       = true,         -- colorize file|git icons
    sort_lastused     = true,         -- sort buffers() by last used
    actions = {
      ["ctrl-x"]      = { actions.buf_del, actions.resume },
    }
  },
  tabs = {
    prompt            = 'Tabs❯ ',
    tab_title         = "Tab",
    tab_marker        = "<<",
    file_icons        = true,         -- show file icons?
    color_icons       = true,         -- colorize file|git icons
    actions = {
      ["default"]     = actions.buf_switch,
      ["ctrl-x"]      = { actions.buf_del, actions.resume },
    },
    fzf_opts = {
      ['--delimiter'] = "'[\\):]'",
      ["--with-nth"]  = '2..',
    },
  },
  lines = {
    previewer         = "builtin",    -- set to 'false' to disable
    prompt            = 'Lines❯ ',
    show_unlisted     = false,        -- exclude 'help' buffers
    no_term_buffers   = true,         -- exclude 'term' buffers
    fzf_opts = {
      ['--delimiter'] = "'[\\]:]'",
      ["--nth"]       = '2..',
      ["--tiebreak"]  = 'index',
    },
    actions = {
      ["default"]     = actions.buf_edit_or_qf,
      ["alt-q"]       = actions.buf_sel_to_qf,
      ["alt-l"]       = actions.buf_sel_to_ll
    },
  },
  blines = {
    previewer         = "builtin",    -- set to 'false' to disable
    prompt            = 'BLines❯ ',
    show_unlisted     = true,         -- include 'help' buffers
    no_term_buffers   = false,        -- include 'term' buffers
    fzf_opts = {
      -- hide filename, tiebreak by line no.
      ['--delimiter'] = "'[\\]:]'",
      ["--with-nth"]  = '2..',
      ["--tiebreak"]  = 'index',
    },
    -- actions inherit from 'actions.buffers' and merge
    actions = {
      ["default"]     = actions.buf_edit_or_qf,
      ["alt-q"]       = actions.buf_sel_to_qf,
      ["alt-l"]       = actions.buf_sel_to_ll
    },
  },
  tags = {
    prompt                = 'Tags❯ ',
    ctags_file            = "tags",
    multiprocess          = true,
    file_icons            = true,
    git_icons             = true,
    color_icons           = true,
    rg_opts               = "--no-heading --color=always --smart-case",
    grep_opts             = "--color=auto --perl-regexp",
    actions = {
      ["ctrl-g"]          = { actions.grep_lgrep }
    },
    no_header             = false,    -- hide grep|cwd header?
    no_header_i           = false,    -- hide interactive header?
  },
  btags = {
    prompt                = 'BTags❯ ',
    ctags_file            = "tags",
    ctags_autogen         = false,    -- dynamically generate ctags each call
    multiprocess          = true,
    file_icons            = true,
    git_icons             = true,
    color_icons           = true,
    rg_opts               = "--no-heading --color=always",
    grep_opts             = "--color=auto --perl-regexp",
    fzf_opts = {
      ['--delimiter']     = "'[\\]:]'",
      ["--with-nth"]      = '2..',
      ["--tiebreak"]      = 'index',
    },
  },
  colorschemes = {
    prompt            = 'Colorschemes❯ ',
    live_preview      = true,       -- apply the colorscheme on preview?
    actions           = { ["default"] = actions.colorscheme, },
    winopts           = { height = 0.55, width = 0.30, },
  },
  quickfix = {
    file_icons        = true,
    git_icons         = true,
  },
  lsp = {
    prompt_postfix    = '❯ ',       -- will be appended to the LSP label
    cwd_only          = false,      -- LSP/diagnostics for cwd only?
    async_or_timeout  = 5000,       -- timeout(ms) or 'true' for async calls
    file_icons        = true,
    git_icons         = false,
    code_actions = {
        prompt            = 'Code Actions> ',
        ui_select         = true,       -- use 'vim.ui.select'?
        async_or_timeout  = 5000,
        winopts = {
            row           = 0.40,
            height        = 0.35,
            width         = 0.60,
        },
    }
  },
  diagnostics ={
    prompt            = 'Diagnostics❯ ',
    cwd_only          = false,
    file_icons        = true,
    git_icons         = false,
    diag_icons        = true,
    icon_padding      = '',     -- add padding for wide diagnostics signs
  },
  file_icon_colors = {
    ["sh"] = "green",
  },
}
