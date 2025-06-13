return {
  'napmn/react-extract.nvim',
  config = function()
    require('react-extract').setup()
    vim.keymap.set({ 'v' }, '<Leader>re', require('react-extract').extract_to_current_file)
  end,
}
