local catppuccin = require("catppuccin")
catppuccin.setup{
  transparent_background = false,
  term_colors = false,
  styles = {
  	comments = "italic",
  	functions = "NONE",
  	keywords = "italic",
  	strings = "NONE",
  	variables = "NONE",
  },
  integrations = {
  	treesitter = false,
  	native_lsp = {
  		enabled = true,
  		virtual_text = {
  			errors = "italic",
  			hints = "italic",
  			warnings = "italic",
  			information = "italic",
  		},
  		underlines = {
  			errors = "underline",
  			hints = "underline",
  			warnings = "underline",
  			information = "underline",
  		},
  	},
  	lsp_trouble = true,
  	cmp = true,
  	lsp_saga = true,
  	gitgutter = false,
  	gitsigns = true,
  	telescope = true,
  	nvimtree = {
  		enabled = true,
  		show_root = false,
  		transparent_panel = false,
  	},
  	which_key = true,
  	indent_blankline = {
  		enabled = true,
  		colored_indent_levels = false,
  	},
  	dashboard = false,
  	neogit = false,
  	vim_sneak = false,
  	fern = false,
  	barbar = true,
  	bufferline = true,
  	markdown = true,
  	lightspeed = true,
  	ts_rainbow = true,
  	hop = true,
  	notify = true,
  	telekasten = true,
  }
}
cmd 'colorscheme catppuccin'
