local buf_map = require("utils").buf_map
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim" },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },
		"folke/neodev.nvim",
	},
	config = function()
		local neodev = require("neodev")
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")
		vim.filetype.add({ extension = { templ = "templ" } })
		function dump(o)
			if type(o) == "table" then
				local s = "{ "
				for k, v in pairs(o) do
					if type(k) ~= "number" then
						k = '"' .. k .. '"'
					end
					s = s .. "[" .. k .. "] = " .. dump(v) .. ","
				end
				return s .. "} "
			else
				return tostring(o)
			end
		end
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Jump to the definition of the word under your cursor.
				--  This is where a variable was first declared, or where a function is defined, etc.
				--  To jump back, press <C-T>.
				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

				-- WARN: This is not Goto Definition, this is Goto Declaration.
				--  For example, in C this would take you to the header
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				-- Find references for the word under your cursor.
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

				-- Jump to the type of the word under your cursor.
				--  Useful when you're not sure what type a variable is and you want to see
				--  the definition of its *type*, not where it was *defined*.
				map("gt", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

				-- Jump to the implementation of the word under your cursor.
				--  Useful when your language has ways of declaring types without an actual implementation.
				map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

				-- Opens a popup that displays documentation about the word under your cursor
				--  See `:help K` for why this keymap
				map("K", vim.lsp.buf.hover, "Hover Documentation")
				map("<leader>K", vim.lsp.buf.signature_help, "Signature Documentation")

				-- Rename the variable under your cursor
				--  Most Language Servers support renaming across files, etc.
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

				-- Execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

				-- Fuzzy find all the symbols in your current document.
				--  Symbols are things like variables, functions, types, etc.
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

				-- Fuzzy find all the symbols in your current workspace
				--  Similar to document symbols, except searches over your whole project.
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				map("<leader>dl", vim.diagnostic.setloclist, "[D]iagnostic [L]oclist")

				map("[d", vim.diagnostic.goto_prev, "Prev [D]iagnostic")
				map("]d", vim.diagnostic.goto_next, "Next [D]iagnostic")

				buf_map("i", "<tab>", 'pumvisible() ? "<c-n>" : "<tab>"', { expr = true, noremap = true })
				buf_map("i", "<s-tab>", 'pumvisible() ? "<c-p>" : "<s-tab>"', { expr = true, noremap = true })
				-- The following two autocommands are used to highlight references of the
				-- word under your cursor when your cursor rests there for a little while.
				--    See `:help CursorHold` for information about when this is executed
				--
				-- When you move your cursor, the highlights will be cleared (the second autocommand).
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end,
		})

		local servers = {
			bashls = {},
			cssls = {},
			dockerls = {},
			gopls = {
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
						gofumpt = true,
						completeUnimported = true,
						usePlaceholders = true,
					},
				},
				-- filetypes = { "go", "gomod", "gowork", "gotmpl" },
				-- gofumpt = true,
				-- analyses = {
				-- 	unusedparams = true,
				-- },
				-- staticcheck = true,
				-- completeUnimported = true,
				-- usePlaceholders = true,
			},
			templ = {},
			html = {},
			htmx = {
				filetypes = { "html", "templ" },
			},
			lua_ls = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = {
						enable = true,
						globals = { "vim", "describe", "it", "before_each", "after_each", "awesome", "theme", "client" },
					},
				},
			},
			biome = {},
			eslint = {},
			-- tsserver = {
			-- 	settings = {
			-- 		implicitProjectConfiguration = {
			-- 			checkJs = true,
			-- 		},
			-- 	},
			-- 	capabilities = {
			-- 		renameProvider = false,
			-- 	},
			-- },
			jsonls = {},
			yamlls = {},
			pylsp = {
				plugins = {
					ruff = {},
				},
			},
			-- pyright = {},
			vtsls = {},
			emmet_language_server = {},
			-- hls = {},
			elixirls = {},
		}

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua", -- Used to format lua code
		})

		neodev.setup()

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_tool_installer.setup({ ensure_installed = ensure_installed })

		mason_lspconfig.setup({
			ensure_installed = vim.tbl_keys(servers),
		})

		-- mason_lspconfig.setup_handlers({
		-- 	function(server_name)
		-- 		require("lspconfig")[server_name].setup({
		-- 			capabilities = capabilities,
		-- 			on_attach = on_attach,
		-- 			settings = servers[server_name],
		-- 			filetypes = (servers[server_name] or {}).filetypes,
		-- 		})
		-- 	end,
		-- })
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
