local function open_three_column_layout(force_split)
  local total = vim.o.columns

  local left_width = math.floor(total * 0.32)
  local middle_width = math.floor(total * 0.36)
  local right_width = total - left_width - middle_width

  local buf = vim.api.nvim_get_current_buf()

  if force_split then
    vim.cmd 'only' -- close all other windows
    vim.cmd 'vsplit' -- create middle
    vim.cmd 'vsplit' -- create right

    vim.cmd 'wincmd t' -- go to leftmost window
    vim.api.nvim_set_current_buf(buf)

    vim.cmd 'wincmd l'
    vim.api.nvim_set_current_buf(buf)

    vim.cmd 'wincmd l'
    vim.api.nvim_set_current_buf(buf)
  else
    vim.cmd 'wincmd t' -- just move to leftmost window
  end

  -- Resize all windows
  vim.cmd 'wincmd t'
  vim.cmd('vertical resize ' .. left_width)
  vim.cmd 'wincmd l'
  vim.cmd('vertical resize ' .. middle_width)
  vim.cmd 'wincmd l'
  vim.cmd('vertical resize ' .. right_width)

  -- Return to middle window
  vim.cmd 'wincmd h'
end

local function open_single_window()
  vim.cmd 'only'
end

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    if vim.fn.argc() == 0 and vim.o.columns > 400 then
      open_three_column_layout(true)
    end
  end,
})

vim.keymap.set('n', '<leader>wr1', open_single_window, { desc = '1-column layout (current buffer)' })
vim.keymap.set('n', '<leader>wr3', function()
  open_three_column_layout(true)
end, { desc = '3-column layout (30/40/30)' })
vim.keymap.set('n', '<leader>wr=', function()
  open_three_column_layout(false)
end, { desc = 'Resize current 3-column layout' })
