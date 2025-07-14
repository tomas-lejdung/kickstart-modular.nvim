return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup {
        options = {
          mode = 'buffers', -- or "tabs"
          diagnostics = 'nvim_lsp',
          offsets = {
            {
              filetype = 'neo-tree',
              text = 'Neo Tree',
              highlight = 'Directory',
              separator = true,
            },
          },
          separator_style = 'slant',
          show_buffer_close_icons = true,
          show_close_icon = false,
        },
      }
    end,
  },
}
