return {
  {
    'mfussenegger/nvim-dap',
    event = 'VeryLazy',
    config = function()
      vim.keymap.set('n', '<leader>tb', function()
        require('dap').toggle_breakpoint()
      end, { desc = 'Toggle DAP breakpoint' })
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dap, dapui = require 'dap', require 'dapui'
      dapui.setup {
        layouts = {
          {
            elements = {
              { id = 'scopes', size = 0.5 },
              { id = 'breakpoints', size = 0.25 },
              { id = 'stacks', size = 0.1 },
              { id = 'watches', size = 0.15 },
            },
            position = 'left',
            size = 50, -- ← change this to control left sidebar width
          },
          {
            elements = {
              { id = 'repl', size = 0.5 },
              { id = 'console', size = 0.5 },
            },
            position = 'bottom',
            size = 10,
          },
        },
      }

      -- Auto open/close dap-ui
      local dap, dapui = require 'dap', require 'dapui'
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  -- {
  --   'theHamsta/nvim-dap-virtual-text',
  --   dependencies = { 'mfussenegger/nvim-dap' },
  --   config = function()
  --     require('nvim-dap-virtual-text').setup()
  --   end,
  -- },
  {
    'leoluz/nvim-dap-go',
    ft = 'go',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      require('dap-go').setup()
    end,
  },
}
