require("lualine").setup({
	options = {
		icons_enabled = true,
		component_separators = "",
		disabled_filetypes = {},
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
      "branch",
      "filesize"
    },
		lualine_c = {
			"diff",
			"diagnostics",
			"selectioncount",
			"searchcount",
		},
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	extensions = { "quickfix", "fugitive" },
})
