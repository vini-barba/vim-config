return {
	"epwalsh/obsidian.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/Documents/repos/personal/notes/",
			},
			{
				name = "work",
				path = "~/Documents/repos/ramper/notes/",
				templates = {
					subdir = "templates/",
					date_format = "%Y-%m-%d-%a",
					time_format = "%H:%M",
				},
			},
		},
		daily_notes = {
			folder = "dailies",
			date_format = "%Y-%m-%d",
			alias_format = "%B %-d, %Y",
			template = nil,
		},

		completion = {
			nvim_cmp = true,
			min_chars = 2,
		},
		mappings = {
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			["<leader>ch"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},
		},
	},
}
