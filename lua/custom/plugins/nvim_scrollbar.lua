return {
  {
    'petertriho/nvim-scrollbar',
    event = 'VeryLazy',
    config = function()
      require('scrollbar').setup {
        handle = {
          text = ' ',
          blend = 60, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
          color = '#ffffff',
          color_nr = nil, -- cterm
          highlight = 'CursorColumn',
          hide_if_all_visible = true, -- Hides handle if all lines are visible
        },
      }
    end,
  },
}
