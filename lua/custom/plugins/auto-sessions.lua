return {
  'rmagatti/auto-session',
  lazy = false,
  keys = {
    -- Will use Telescope if installed or a vim.ui.select picker otherwise
    { '<leader>Wr', '<cmd>AutoSession search<CR>', desc = 'Session search' },
    { '<leader>Ws', '<cmd>AutoSession save<CR>', desc = 'Save session' },
    { '<leader>Wa', '<cmd>AutoSession toggle<CR>', desc = 'Toggle autosave' },
  },
  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
    -- log_level = 'debug',
  },
}
