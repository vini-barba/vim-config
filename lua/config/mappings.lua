local wk = require("which-key")
local map = require('utils').map


vim.api.nvim_set_keymap('n', '<C-_>', 'gc <CR>', {})
vim.api.nvim_set_keymap('v', '<C-_>', 'gc <CR>', {})

-- Normal mode
wk.register(
  {
    c = {
      name = "Terminal (console)",
      h = { "<cmd>split | terminal<cr><cmd>resize 15<cr>", "Open a terminal in a horizontal split" },
      v = { ":vsplit | terminal<cr>:vertical resize 40<cr>", "Open a terminal in a vertical split" },
      t = { ":tabnew | terminal<cr>", "Create a new tab with a terminal" }
    },

    f = {
      name = "Finder",
      b = { '[F]ind [B]uffers' },
      d = { '[F]ind [D]iagnostics' },
      f = { '[F]ind [F]iles' },
      g = { '[F]ind - [G]rep' },
      ["/"] = { '[/] Fuzzily search in current buffer' },
    },

    pv = { '<cmd>NvimTreeToggle<CR>', "Project view" },
    u = { '<cmd>UndotreeToggle<CR>', "Undotree" },

    tf = { '<cmd>KickstartFormatToggle<CR>', "[T]oggle [F]ormat" },

    h = { "<C-w>h", "Move to left split" },
    j = { "<C-w>j", "Move to split below" },
    k = { "<C-w>k", "Move to split above" },
    l = { "<C-w>l", "Move to right split" },
    ["<space>"] = { ":nohlsearch<CR>", "Clear search" },
  }, { prefix = "<leader>", mode = "n" })

-- Terminal mode
map('t', '<leader>cc', "<C-\\><C-n><cr>")
wk.register({
  c = {
    name = "Terminal (console)",
    q = { "<Esc> <C-\\><C-n><cmd>q!<cr>", "Close terminal when in insert mode" },
    c = { "Go to normal mode in terminal" }
  }
}, { prefix = "<leader>", mode = "t" })


return wk
