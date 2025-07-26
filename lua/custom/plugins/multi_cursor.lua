return {
  {
    'jake-stewart/multicursor.nvim',
    branch = '1.0',
    config = function()
      local mc = require 'multicursor-nvim'
      mc.setup()

      local set = vim.keymap.set

      -- ALT + Up/Down to add cursors above/below (always active)
      set({ 'n', 'x' }, '<M-Up>', function()
        mc.lineAddCursor(-1)
      end, { desc = 'Add cursor above' })
      set({ 'n', 'x' }, '<M-Down>', function()
        mc.lineAddCursor(1)
      end, { desc = 'Add cursor below' })

      -- Ctrl+n to always add next match
      set({ 'n', 'x' }, '<C-n>', function()
        mc.matchAddCursor(1)
      end, { desc = 'Add next match' })
      -- Ctrl+N to always add previous match
      set({ 'n', 'x' }, '<C-S-n>', function()
        mc.matchAddCursor(-1)
      end, { desc = 'Add previous match' })
      -- Ctrl+s to always skip next match
      set({ 'n', 'x' }, '<C-s>', function()
        mc.matchSkipCursor(1)
      end, { desc = 'Skip next match' })

      -- Mappings only active when multiple cursors are enabled
      mc.addKeymapLayer(function(layerSet)
        -- Arrow keys to skip lines
        layerSet({ 'n', 'x' }, '<up>', function()
          mc.lineSkipCursor(-1)
        end, { desc = 'Skip line above' })
        layerSet({ 'n', 'x' }, '<down>', function()
          mc.lineSkipCursor(1)
        end, { desc = 'Skip line below' })

        -- Matching word-based cursor adding/skipping
        layerSet({ 'n', 'x' }, '<leader>n', function()
          mc.matchAddCursor(1)
        end, { desc = 'Add next match' })
        layerSet({ 'n', 'x' }, '<leader>s', function()
          mc.matchSkipCursor(1)
        end, { desc = 'Skip next match' })
        layerSet({ 'n', 'x' }, '<leader>N', function()
          mc.matchAddCursor(-1)
        end, { desc = 'Add previous match' })
        layerSet({ 'n', 'x' }, '<leader>S', function()
          mc.matchSkipCursor(-1)
        end, { desc = 'Skip previous match' })

        -- Switch between cursors
        layerSet({ 'n', 'x' }, '<left>', mc.prevCursor, { desc = 'Previous cursor' })
        layerSet({ 'n', 'x' }, '<right>', mc.nextCursor, { desc = 'Next cursor' })

        -- Delete main cursor
        layerSet({ 'n', 'x' }, '<leader>x', mc.deleteCursor, { desc = 'Delete current cursor' })

        -- Enable or clear cursors with Esc
        layerSet('n', '<esc>', function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end, { desc = 'Toggle/clear cursors' })
      end)

      -- Alt + mouse support
      set('n', '<M-leftmouse>', mc.handleMouse)
      set('n', '<M-leftdrag>', mc.handleMouseDrag)
      set('n', '<M-leftrelease>', mc.handleMouseRelease)

      -- Toggle cursors manually
      set({ 'n', 'x' }, '<c-q>', mc.toggleCursor, { desc = 'Toggle multicursor' })

      -- Customize how cursors look.
      local hl = vim.api.nvim_set_hl
      hl(0, 'MultiCursorCursor', { reverse = true })
      hl(0, 'MultiCursorVisual', { link = 'Visual' })
      hl(0, 'MultiCursorSign', { link = 'SignColumn' })
      hl(0, 'MultiCursorMatchPreview', { link = 'Search' })
      hl(0, 'MultiCursorDisabledCursor', { reverse = true })
      hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
      hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
    end,
  },
}
