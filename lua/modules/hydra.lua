local Hydra = require("hydra")
local gitsigns = require("gitsigns")

local function cmd(command)
  return table.concat({ "<Cmd>", command, "<CR>" })
end

Hydra({
  name = "Side scroll",
  mode = "n",
  body = "z",
  heads = {
    { "h", "5zh" },
    { "l", "5zl", { desc = "←/→" } },
    { "H", "zH" },
    { "L", "zL",  { desc = "half screen ←/→" } },
  },
})

local git_hint = [[
 _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _K_: prev hunk   _u_: undo stage hunk   _p_: preview hunk   _B_: blame show full
 _A_: add all     _a_: add buffer        _m_: git commit     _u_: git push
 ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
 ^
 ^ ^              _<Enter>_: Neogit              _q_: exit
]]

Hydra({
  hint = git_hint,
  config = {
    color = "pink",
    invoke_on_body = true,
    hint = {
      position = "bottom",
      border = "rounded",
    },
    on_enter = function()
      vim.bo.modifiable = false
      gitsigns.toggle_signs(true)
      gitsigns.toggle_linehl(true)
    end,
    on_exit = function()
      gitsigns.toggle_signs(false)
      gitsigns.toggle_linehl(false)
      gitsigns.toggle_deleted(false)
    end,
  },
  mode = { "n", "x" },
  body = "<leader>g",
  heads = {
    {
      "J",
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gitsigns.next_hunk()
        end)
        return "<Ignore>"
      end,
      { expr = true },
    },
    {
      "K",
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gitsigns.prev_hunk()
        end)
        return "<Ignore>"
      end,
      { expr = true },
    },
    { "s", ":Gitsigns stage_hunk<CR>", { silent = true } },
    { "u", gitsigns.undo_stage_hunk },
    { "S", gitsigns.stage_buffer },
    { "p", gitsigns.preview_hunk },
    { "d", gitsigns.toggle_deleted,    { nowait = true } },
    { "b", gitsigns.blame_line },
    {
      "B",
      function()
        gitsigns.blame_line({ full = true })
      end,
    },
    { "/",       gitsigns.show,     { exit = true } }, -- show the base of the file
    { "<Enter>", "<cmd>Neogit<CR>", { exit = true } },
    { "q",       nil,               { exit = true, nowait = true } },
    { "a",       cmd("Git add %:p") },
    { "A",       cmd("Git add .") },
    { "m",       cmd("Git commit") },
    { "u",       cmd("Git push") },
  },
})

local telescope_hint = [[
                 _f_: files         _m_: marks
   🭇🬭🬭🬭🬭🬭🬭🬭🬭🬼    _o_: old files     _g_: live grep
  🭉🭁🭠🭘    🭣🭕🭌🬾   _p_: projects      _/_: search in file
  🭅█ ▁     █🭐
  ██🬿      🭊██   _h_: vim help      _c_: execute command
 🭋█🬝🮄🮄🮄🮄🮄🮄🮄🮄🬆█🭀  _k_: keymap        _;_: commands history
 🭤🭒🬺🬹🬱🬭🬭🬭🬭🬵🬹🬹🭝🭙  _r_: registers     _?_: search history
                 _e_: file_browser  _\_: resume

                 _<Enter>_: Telescope           _<Esc>_
]]

Hydra({
  name = "Telescope",
  hint = telescope_hint,
  config = {
    color = "teal",
    invoke_on_body = true,
    hint = {
      position = "middle",
      border = "rounded",
    },
  },
  mode = "n",
  body = "<Leader>*",
  heads = {
    { "f",       cmd("Telescope find_files") },
    { "g",       cmd("Telescope live_grep") },
    { "h",       cmd("Telescope help_tags"),                 { desc = "Vim help" } },
    { "o",       cmd("Telescope oldfiles"),                  { desc = "Recently opened files" } },
    { "m",       cmd("MarksListBuf"),                        { desc = "Marks" } },
    { "k",       cmd("Telescope keymaps") },
    { "r",       cmd("Telescope registers") },
    { "e",       cmd("Telescope file_browser") },
    { "'",       cmd("Telescope resume") },
    { "p",       cmd("Telescope projects"),                  { desc = "Projects" } },
    { "/",       cmd("Telescope current_buffer_fuzzy_find"), { desc = "Search in file" } },
    { "?",       cmd("Telescope search_history"),            { desc = "Search history" } },
    { ";",       cmd("Telescope command_history"),           { desc = "Command-line history" } },
    { "c",       cmd("Telescope commands"),                  { desc = "Execute command" } },
    { "<Enter>", cmd("Telescope"),                           { exit = true, desc = "List all pickers" } },
    { "<Esc>",   nil,                                        { exit = true, nowait = true } },
  },
})
