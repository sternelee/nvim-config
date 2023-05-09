require("nvim-tree").setup({
    auto_reload_on_write = true,
    disable_netrw = true,
    hijack_netrw = true,
    open_on_tab = false,
    hijack_cursor = false,
    sync_root_with_cwd = true,
    system_open = {
        cmd = nil,
        args = {},
    },
    update_focused_file = {
        enable = true,
        update_root = false,
        ignore_list = {},
    },
    -- view = {
    --   side = 'right'
    -- },
    filters = {
        dotfiles = false,
        custom = { "^\\.git" },
        exclude = {},
    },
})
