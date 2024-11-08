local wk = require("which-key")
local map = require("utils").map

vim.api.nvim_set_keymap("n", "<C-_>", "gc <CR>", {})
vim.api.nvim_set_keymap("v", "<C-_>", "gc <CR>", {})

map("t", "<leader>cc", "<C-\\><C-n><cr>")

wk.add({
	{
		mode = "n",
		{
			{ "<leader>h", "<C-w>h", desc = "Move to left split" },
			{ "<leader>j", "<C-w>j", desc = "Move to split below" },
			{ "<leader>k", "<C-w>k", desc = "Move to split above" },
			{ "<leader>l", "<C-w>l", desc = "Move to right split" },
			{ "<leader><space>", ":nohlsearch<CR>", desc = "Clear search" },
		},
	},
	{
		mode = "n",
		"<leader>pv",
		require("oil").open_float,
		desc = "[P]roject [V]iew",
	},
	{
		mode = "n",
		"<leader>u",
		"<cmd>UndotreeToggle<CR>",
		desc = "Undotree",
	},
	{
		"<leader>tf",
		"<cmd>KickstartFormatToggle<CR>",
		desc = "[T]oggle [F]ormat",
	},
	{
		"<leader>f",
		group = "Finder",
		{
			mode = "n",
			{ "<leader>fb", desc = "[F]ind [B]uffers" },
			{ "<leader>fd", desc = "[F]ind [D]iagnostics" },
			{ "<leader>ff", desc = "[F]ind [F]iles" },
			{ "<leader>fg", desc = "[F]ind - [G]rep" },
			{ "<leader>f/", desc = "[/] Fuzzily search in current buffer" },
		},
	},
	{
		"<leader>c",
		group = "Terminal (console)",
		{
			mode = "t",
			{ "<leader>cq", "<Esc> <C-\\><C-n><cmd>q!<cr>", desc = "Close terminal when in insert mode" },
			{ "<leader>cc", desc = "Go to normal mode in terminal" },
		},
		{
			mode = "n",
			{
				"<leader>ch",
				"<cmd>split | terminal<cr><cmd>resize 15<cr>",
				desc = "Open a terminal in a horizontal split",
			},
			{
				"<leader>cv",
				":vsplit | terminal<cr>:vertical resize 40<cr>",
				desc = "Open a terminal in a vertical split",
			},
			{ "<leader>ct", ":tabnew | terminal<cr>", desc = "Create a new tab with a terminal" },
		},
	},
})

return wk
