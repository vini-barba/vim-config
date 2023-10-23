vim.cmd([[
    hi BqfPreviewBorder guifg=#3e8e2d ctermfg=71
    hi BqfPreviewTitle guifg=#3e8e2d ctermfg=71
    hi BqfPreviewThumb guibg=#3e8e2d ctermbg=71
    hi link BqfPreviewRange Search
]])

require('bqf').setup({
  auto_enable = true,
  auto_resize_height = true, -- highly recommended enable
  preview = {
    win_height = 12,
    win_vheight = 12,
    delay_syntax = 80,
    border = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' },
    show_title = false,
    should_preview_cb = function(bufnr, qwinid)
      local ret = true
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      local fsize = vim.fn.getfsize(bufname)
      if fsize > 100 * 1024 then
        -- skip file size greater than 100k
        ret = false
      elseif bufname:match('^fugitive://') then
        -- skip fugitive buffer
        ret = false
      end
      return ret
    end
  },
  -- make `drop` and `tab drop` to become preferred
  func_map = {
    drop = 'o',
    openc = 'O',
    split = '<C-s>',
    tabdrop = '<C-t>',
    -- set to empty string to disable
    tabc = '',
    ptogglemode = 'z,',
  },
  filter = {
    fzf = {
      action_for = {
        ['ctrl-t'] = {
          description = [[Press ctrl-t to open up the item in a new tab]],
          default = 'tabedit'
        },
        ['ctrl-v'] = {
          description = [[Press ctrl-v to open up the item in a new vertical split]],
          default = 'vsplit'
        },
        ['ctrl-x'] = {
          description = [[Press ctrl-x to open up the item in a new horizontal split]],
          default = 'split'
        },
        ['ctrl-q'] = {
          description = [[Press ctrl-q to toggle sign for the selected items]],
          default = 'signtoggle'
        },
        ['ctrl-c'] = {
          description = [[Press ctrl-c to close quickfix window and abort fzf]],
          default = 'closeall'
        }
      },
      extra_opts = { '--bind', 'ctrl-o:toggle-all', '--prompt', '> ' }
    }
  }
})
