local apply_options = require("utils").apply_options
local apply_globals = require("utils").apply_globals

apply_globals({
	mapleader = " ",
	loaded_python_provider = 0,
	python3_host_prog = "/usr/bin/python3",
	spellfile_URL = "https://ftp.nluug.nl/vim/runtime/spell",
})

apply_options({
	compatible = false,
	backup = false,
	writebackup = false,
	swapfile = false,
	undodir = os.getenv("HOME") .. "/.config/nvim/undodir",
	undofile = true,
	cursorline = true,
	lazyredraw = true,
	showcmd = true,
	cmdheight = 1,
	ruler = true,
	completeopt = { "menuone", "noinsert", "noselect" },
	incsearch = true,
	hlsearch = true,
	smartcase = true,
	ignorecase = true,
	wrap = false,
	expandtab = true,
	smarttab = true,
	tabstop = 2,
	softtabstop = 2,
	shiftwidth = 2,
	autoindent = true,
	smartindent = true,
	number = true,
	relativenumber = true,
	timeout = true,
	timeoutlen = 1000,
	ttimeoutlen = 50,
	path = vim.opt.path + { "**" },
	wildmenu = true,
	wildignore = vim.opt.wildignore + {
		"*/.git/*",
		"*/.hg/*",
		"*/.svn/*.",
		"*/.vscode/*.",
		"*/.DS_Store",
		"*/dist*/*",
		"*/target/*",
		"*/builds/*",
		"*/build/*",
		"tags",
		"*/lib/*",
		"*/flow-typed/*",
		"*/node_modules/*",
		"*.png",
		"*.PNG",
		"*.jpg",
		"*.jpeg",
		"*.JPG",
		"*.JPEG",
		"*.pdf",
		"*.exe",
		"*.o",
		"*.obj",
		"*.dll",
		"*.DS_Store",
		"*.ttf",
		"*.otf",
		"*.woff",
		"*.woff2",
		"*.eot",
		"*/coverage*/*",
	},
	encoding = "utf-8",
	fileencoding = "utf-8",
	autoread = true,
	splitbelow = true,
	splitright = true,
	showmatch = true,
	colorcolumn = "80",
	clipboard = "unnamedplus",
	foldlevel = 20,
	foldmethod = "expr",
	foldexpr = "nvim_treesitter#foldexpr()",
	conceallevel = 2,
	-- spell = true,
	-- spelllang = { "en_us", "pt_br" },
})

-- Set the spell check languages (English and Portuguese)
-- vim.opt.spelllang:append("en_us", "pt_BR")

-- Set the spell check dictionary directory
-- vim.opt.spellfile = vim.opt.spellfile + "/usr/share/aspell/"
