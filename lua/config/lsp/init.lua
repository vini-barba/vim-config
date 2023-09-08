local neodev = require('neodev')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local capabilities = require("config.lsp.capabilities").capabilities
local on_attach = require("config.lsp.on_attach").on_attach

neodev.setup()

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

local servers = {
  bashls = {},
  cssls = {},
  dockerls = {},
  gopls = {
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    gopls = {
      gofumpt = true,
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      completeUnimported = true,
      usePlaceholders = true,
    },
  },
  html = {},
  jsonls = {},
  lua_ls = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
      },
      diagnostics = {
        enable = true,
        globals = { "vim", "describe", "it", "before_each", "after_each", "awesome", "theme", "client" }
      }
    }
  },
  tsserver = {},
  yamlls = {},
  jdtls = {},
}

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}
