return {
  {
    'AckslD/nvim-neoclip.lua',
    dependencies = {
      'nvim-telescope/telescope.nvim', -- or use fzf-lua if you prefer
      'nvim-lua/plenary.nvim', -- required
    },
    config = function()
      require('neoclip').setup()
    end,
    keys = {
      { '<leader>sc', '<cmd>Telescope neoclip<CR>', desc = '[C]lipboard history' },
    },
  },
}
