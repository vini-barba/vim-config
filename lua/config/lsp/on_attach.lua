local M = {}
local wk = require("config.mappings")
local buf_map = require('utils').buf_map

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc, noremap = true, silent = true, })
  end

  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gt', vim.lsp.buf.type_definition, '[G]oto [T]ype Definition')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>K', vim.lsp.buf.signature_help, 'Signature Documentation')

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  -- nmap('<leader>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })


  -- nmap('<leader>d', vim.diagnostic.open_float({ scope = "buffer" }), 'Open [D]iagnostic')
  nmap('<leader>dl', vim.diagnostic.setloclist, "[D]iagnostic [L]oclist")

  nmap('[d', vim.diagnostic.goto_prev, "Prev [D]iagnostic")
  nmap(']d', vim.diagnostic.goto_next, "Next [D]iagnostic")

  wk.register({
    g = {
      name = "Go to",
      d = { "Go to declaration" },
      D = { "Go to definition" },
      t = { "Go to type definition" },
      i = { "Go to type implementation" },
      r = { "Go to references" }
    },
    ["<leader"] = {
      ca = { "[C]ode [A]ction" },
      d = { "Open [D]iagnostic" },
      dl = { "[D]iagnostic [L]oclist" },
      -- f = { "<cmd>Format<CR>", "[F]ormat" },
      rn = { "[R]e[n]ame" },
      K = { 'Hover Documentation' },
    },
    ["[d"] = { "Go to prev diagnostic" },
    ["]d"] = { "Go to next diagnostic" },
  }, { mode = "n", buffer = bufnr })

  buf_map('i', '<tab>', 'pumvisible() ? "<c-n>" : "<tab>"', { expr = true, noremap = true })
  buf_map('i', '<s-tab>', 'pumvisible() ? "<c-p>" : "<s-tab>"', { expr = true, noremap = true })
end


M.on_attach = on_attach

return M
