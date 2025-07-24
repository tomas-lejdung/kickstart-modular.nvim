local function open_three_column_layout()
  local total = vim.o.columns

  local left_width = math.floor(total * 0.32)
  local middle_width = math.floor(total * 0.36)
  local right_width = total - left_width - middle_width

  -- Save current buffer and window
  local buf = vim.api.nvim_get_current_buf()

  -- Close other windows but keep current buffer
  vim.cmd 'only'

  -- Create two vertical splits
  vim.cmd 'vsplit'
  vim.cmd 'vsplit'

  -- Move to leftmost window
  vim.cmd 'wincmd h'
  vim.cmd 'wincmd h'

  -- Set current buffer in all 3 windows
  vim.api.nvim_set_current_buf(buf)
  vim.cmd 'wincmd l'
  vim.api.nvim_set_current_buf(buf)
  vim.cmd 'wincmd l'
  vim.api.nvim_set_current_buf(buf)

  -- Resize
  vim.cmd 'wincmd h'
  vim.cmd 'wincmd h'
  vim.cmd('vertical resize ' .. left_width)
  vim.cmd 'wincmd l'
  vim.cmd('vertical resize ' .. middle_width)
  vim.cmd 'wincmd l'
  vim.cmd('vertical resize ' .. right_width)

  -- Return to middle
  vim.cmd 'wincmd h'
end

local function open_single_window()
  vim.cmd 'only'
end

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    if vim.fn.argc() == 0 then
      open_three_column_layout()
    end
  end,
})

vim.keymap.set('n', '<leader>wr1', open_single_window, { desc = '1-column layout (current buffer)' })
vim.keymap.set('n', '<leader>wr3', open_three_column_layout, { desc = '3-column layout (30/40/30)' })
