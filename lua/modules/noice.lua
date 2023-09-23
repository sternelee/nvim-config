require("noice").setup({
    lsp = {
        progress = {
            enabled = false,
        },
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
        hover = {
            enabled = false,
        },
        signature = {
            enabled = false,
        },
        message = {
            enabled = false,
        },
    },
    presets = {
        bottom_search = true,
        command_palette = false,
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,
        lsp_doc_border = false,
    },
    throttle = 1000 / 40,
})
