return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-go',
    },
    config = function()
      local neotest = require 'neotest'

      neotest.setup {
        adapters = {
          require 'neotest-go' {
            experimental = {
              test_table = true,
            },
            args = { '-count=1', '-timeout=600s', '-coverprofile=$(git rev-parse --show-toplevel)/coverage.out' },
          },
        },
      }

      -- <leader>T keybinds
      vim.keymap.set('n', '<leader>Tt', function()
        neotest.run.run()
      end, { desc = 'Run nearest test' })

      vim.keymap.set('n', '<leader>Tf', function()
        neotest.run.run(vim.fn.expand '%')
      end, { desc = 'Run test file' })

      vim.keymap.set('n', '<leader>Tx', function()
        neotest.run.stop()
      end, { desc = 'Stop running test' })

      vim.keymap.set('n', '<leader>Tw', function()
        neotest.watch.toggle(vim.fn.expand '%')
      end, { desc = 'Watch test file' })

      vim.keymap.set('n', '<leader>To', function()
        neotest.output.open { enter = true }
      end, { desc = 'Open output window' })

      vim.keymap.set('n', '<leader>TP', function()
        neotest.output_panel.toggle()
      end, { desc = 'Toggle output panel' })

      vim.keymap.set('n', '<leader>Ts', function()
        neotest.summary.toggle()
      end, { desc = 'Toggle summary window' })

      vim.keymap.set('n', '<leader>Td', function()
        neotest.run.run { strategy = 'dap' }
      end, { desc = 'Debug nearest test with DAP' })
    end,
  },
}
