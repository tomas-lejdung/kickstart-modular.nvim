return {
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    event = 'BufReadPre',
    config = function()
      require('nvim-treesitter-textobjects').setup {
        select = {
          lookahead = true,
          selection_modes = {
            ['@parameter.outer'] = 'v',
            ['@function.outer'] = 'V',
            ['@class.outer'] = '<c-v>',
          },
          include_surrounding_whitespace = true,
        },
        move = {
          set_jumps = true,
        },
      }

      vim.keymap.set({ 'x', 'o' }, 'a=', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@assignment.outer', 'textobjects')
      end, { desc = 'Select outer part of an assignment' })
      vim.keymap.set({ 'x', 'o' }, 'i=', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@assignment.inner', 'textobjects')
      end, { desc = 'Select inner part of an assignment' })
      vim.keymap.set({ 'x', 'o' }, 'l=', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@assignment.lhs', 'textobjects')
      end, { desc = 'Select left hand side of an assignment' })
      vim.keymap.set({ 'x', 'o' }, 'r=', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@assignment.rhs', 'textobjects')
      end, { desc = 'Select right hand side of an assignment' })

      vim.keymap.set({ 'x', 'o' }, 'af', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'if', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')
      end)

      vim.keymap.set({ 'x', 'o' }, 'am', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')
      end, { desc = 'Select outer part of a method/function definition' })
      vim.keymap.set({ 'x', 'o' }, 'im', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')
      end, { desc = 'Select inner part of a method/function definition' })

      vim.keymap.set({ 'x', 'o' }, 'ac', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects')
      end, { desc = 'Select outer part of a class' })
      vim.keymap.set({ 'x', 'o' }, 'ic', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects')
      end, { desc = 'Select inner part of a class' })

      vim.keymap.set({ 'n', 'x', 'o' }, ']f', function()
        require('nvim-treesitter-textobjects.move').goto_next_start('@call.outer', 'textobjects')
      end, { desc = 'Next function call start' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']m', function()
        require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer', 'textobjects')
      end, { desc = 'Next method/function def start' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']c', function()
        require('nvim-treesitter-textobjects.move').goto_next_start('@class.outer', 'textobjects')
      end, { desc = 'Next class start' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']i', function()
        require('nvim-treesitter-textobjects.move').goto_next_start('@conditional.outer', 'textobjects')
      end, { desc = 'Next conditional start' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']l', function()
        require('nvim-treesitter-textobjects.move').goto_next_start('@loop.outer', 'textobjects')
      end, { desc = 'Next loop start' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']s', function()
        require('nvim-treesitter-textobjects.move').goto_next_start('@local.scope', 'locals')
      end, { desc = 'Next scope' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']z', function()
        require('nvim-treesitter-textobjects.move').goto_next_start('@fold', 'folds')
      end, { desc = 'Next fold' })

      vim.keymap.set({ 'n', 'x', 'o' }, ']F', function()
        require('nvim-treesitter-textobjects.move').goto_next_end('@call.outer', 'textobjects')
      end, { desc = 'Next function call end' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']M', function()
        require('nvim-treesitter-textobjects.move').goto_next_end('@function.outer', 'textobjects')
      end, { desc = 'Next method/function def end' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']C', function()
        require('nvim-treesitter-textobjects.move').goto_next_end('@class.outer', 'textobjects')
      end, { desc = 'Next class end' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']I', function()
        require('nvim-treesitter-textobjects.move').goto_next_end('@conditional.outer', 'textobjects')
      end, { desc = 'Next conditional end' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']L', function()
        require('nvim-treesitter-textobjects.move').goto_next_end('@loop.outer', 'textobjects')
      end, { desc = 'Next loop end' })

      vim.keymap.set({ 'n', 'x', 'o' }, '[f', function()
        require('nvim-treesitter-textobjects.move').goto_previous_start('@call.outer', 'textobjects')
      end, { desc = 'Prev function call start' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[m', function()
        require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer', 'textobjects')
      end, { desc = 'Prev method/function def start' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[c', function()
        require('nvim-treesitter-textobjects.move').goto_previous_start('@class.outer', 'textobjects')
      end, { desc = 'Prev class start' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[i', function()
        require('nvim-treesitter-textobjects.move').goto_previous_start('@conditional.outer', 'textobjects')
      end, { desc = 'Prev conditional start' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[l', function()
        require('nvim-treesitter-textobjects.move').goto_previous_start('@loop.outer', 'textobjects')
      end, { desc = 'Prev loop start' })

      vim.keymap.set({ 'n', 'x', 'o' }, '[F', function()
        require('nvim-treesitter-textobjects.move').goto_previous_end('@call.outer', 'textobjects')
      end, { desc = 'Prev function call end' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[M', function()
        require('nvim-treesitter-textobjects.move').goto_previous_end('@function.outer', 'textobjects')
      end, { desc = 'Prev method/function def end' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[C', function()
        require('nvim-treesitter-textobjects.move').goto_previous_end('@class.outer', 'textobjects')
      end, { desc = 'Prev class end' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[I', function()
        require('nvim-treesitter-textobjects.move').goto_previous_end('@conditional.outer', 'textobjects')
      end, { desc = 'Prev conditional end' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[L', function()
        require('nvim-treesitter-textobjects.move').goto_previous_end('@loop.outer', 'textobjects')
      end, { desc = 'Prev loop end' })

      local ts_repeat_move = require 'nvim-treesitter-textobjects.repeatable_move'

      vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
      vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)

      vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
      vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
      vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
      vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
    end,
  },
}
