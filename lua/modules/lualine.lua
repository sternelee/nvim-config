-- lualine config

local lsp_progress = function()
	local messages = vim.lsp.util.get_progress_messages()
	if #messages == 0 then
		return ""
	end
	local status = {}
	for _, msg in pairs(messages) do
		table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
	end
	local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
	local ms = vim.loop.hrtime() / 1000000
	local frame = math.floor(ms / 120) % #spinners
	return spinners[frame + 1] .. " " .. table.concat(status, " | ")
end

require("lualine").setup({
	options = {
		icons_enabled = true,
		component_separators = "",
		-- component_separators = { left = '', right = ''},
		-- section_separators = { left = '', right = ''},
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
			lsp_progress,
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
