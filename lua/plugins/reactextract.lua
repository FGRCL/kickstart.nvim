return {
  'napmn/react-extract.nvim',
  config = function()
    vim.keymap.set({ 'v' }, '<Leader>re', require('react-extract').extract_to_current_file)
  end,
}
