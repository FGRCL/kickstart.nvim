return {
  'moevis/base64.nvim',
  config = function()
    vim.api.nvim_set_keymap('n', '<leader>d', ':Base64Decode', {})
    vim.api.nvim_set_keymap('v', '<leader>d', ':Base64Decode', {})

    vim.api.nvim_set_keymap('n', '<leader>e', ':Base64Encode', {})
    vim.api.nvim_set_keymap('v', '<leader>e', ':Base64Encode', {})
  end,
}
