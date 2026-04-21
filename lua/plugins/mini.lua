return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.surround').setup()
    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = vim.g.have_nerd_font }
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end
    require('mini.move').setup {}
    require('mini.animate').setup {
      cursor = {
        enable = true,
        timing = require('mini.animate').gen_timing.exponential { easing = 'out', duration = 150, unit = 'total' },
      },
      scroll = {
        enable = true,
        timing = require('mini.animate').gen_timing.exponential { easing = 'out', duration = 150, unit = 'total' },
      },
      resize = {
        enable = false,
      },
      open = {
        enable = false,
      },
      close = {
        enable = false,
      },
    }

    require('mini.notify').setup {}
  end,
}
