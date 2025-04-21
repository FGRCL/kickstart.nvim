local leet_arg = 'leetcode.nvim'

return {
  'kawre/leetcode.nvim',
  lazy = leet_arg ~= vim.fn.argv(0, -1),
  opts = { arg = leet_arg },
  build = ':TSUpdate html',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
}
