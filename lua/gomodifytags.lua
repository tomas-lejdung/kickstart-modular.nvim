-- Add or remove tags to struct under cursor or visual range using gomodifytags

-- Core function: called with known range
local function modify_tags(is_add, tag_type, start_line, end_line)
  local filename = vim.fn.expand '%:p'

  -- Use provided range or fallback to current line
  if not start_line or not end_line then
    start_line = vim.fn.line '.'
    end_line = start_line
  end

  local cmd = {
    'gomodifytags',
    '-file',
    filename,
    '-line',
    string.format('%d,%d', start_line, end_line),
    is_add and '-add-tags' or '-remove-tags',
    tag_type,
    '-transform',
    'camelcase',
    '--skip-unexported',
    '-w',
  }

  vim.notify(string.format('Running: %s', table.concat(cmd, ' ')), vim.log.levels.INFO)
  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stderr = function(_, data)
      if data then
        vim.notify(table.concat(data, '\n'), vim.log.levels.ERROR)
      end
    end,
    on_exit = function()
      vim.cmd 'edit!' -- reload buffer to show updated tags
    end,
  })
end

-- Global function to handle range-based calls
function modify_tags_with_range(is_add, tag_type)
  local start_line = vim.fn.line "'<"
  local end_line = vim.fn.line "'>"
  modify_tags(is_add, tag_type, start_line, end_line)
end

-- Keymaps for normal mode
vim.keymap.set('n', '<leader>ctj', function()
  modify_tags(true, 'json')
end, { desc = 'Add JSON tags to struct' })

vim.keymap.set('n', '<leader>ctJ', function()
  modify_tags(false, 'json')
end, { desc = 'Remove JSON tags from struct' })

-- Keymaps for visual mode - using range commands
vim.keymap.set('v', '<leader>ctj', ':<C-u>lua modify_tags_with_range(true, "json")<CR>', { desc = 'Add JSON tags to struct (visual)' })

vim.keymap.set('v', '<leader>ctJ', ':<C-u>lua modify_tags_with_range(false, "json")<CR>', { desc = 'Remove JSON tags from struct (visual)' })
