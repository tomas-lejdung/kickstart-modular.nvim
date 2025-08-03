return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      { 'fredrikaverpil/neotest-golang', version = '*' },
    },
    config = function()
      local neotest = require 'neotest'

      local neotest_ns = vim.api.nvim_create_namespace 'neotest'
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
            return message
          end,
        },
      }, neotest_ns)
      local neotest_golang_opts = {
        runner = 'go',
        testify_enabled = true,
        go_test_args = {
          '-v',
          '-race',
          '-count=1',
          '-timeout=600s',
          '-coverprofile=' .. vim.fn.getcwd() .. '/coverage.out',
        },
      } -- Specify custom configuration
      neotest.setup {
        adapters = {
          require 'neotest-golang'(neotest_golang_opts),
        },
      }

      -- <leader>T keybinds
      vim.keymap.set('n', '<leader>Tt', function()
        neotest.output_panel.clear()
        neotest.run.run()
      end, { desc = 'Run nearest test' })

      vim.keymap.set('n', '<leader>Tl', function()
        neotest.output_panel.clear()
        neotest.run.run_last()
      end, { desc = 'Run last test' })

      vim.keymap.set('n', '<leader>Tf', function()
        neotest.output_panel.clear()
        neotest.run.run(vim.fn.expand '%')
      end, { desc = 'Run test file' })

      vim.keymap.set('n', '<leader>TS', function()
        neotest.output_panel.clear()
        neotest.run.run { suite = true }
      end, { desc = 'Run test Suite' })

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

      vim.keymap.set('n', '<leader>TC', function()
        neotest.output_panel.clear()
      end, { desc = 'Clear output panel' })

      vim.keymap.set('n', '<leader>Ts', function()
        neotest.summary.toggle()
      end, { desc = 'Toggle summary window' })

      vim.keymap.set('n', '<leader>Td', function()
        neotest.run.run { strategy = 'dap' }
      end, { desc = 'Debug nearest test with DAP' })
    end,
  },
}
