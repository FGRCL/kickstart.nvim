return {
  html = {
    -- LSP configuration
    lsp = {
      servers = {
        {
          server = 'html',
          config = {},
        },
        {
          server = 'htmlhint',
          config = {},
        },
      },
    },

    -- Formatter configuration
    formatter = {
      name = 'prettier',
      ensure_installed = true,
    },

    -- Treesitter configuration
    treesitter = {
      parsers = { 'html' },
    },
  },

  css = {
    -- LSP configuration
    lsp = {
      servers = {
        {
          server = 'cssls',
          config = {},
        },
        {
          server = 'stylelint',
          config = {},
        },
        {
          server = 'tailwindcss',
          config = {},
        },
      },
    },

    -- Formatter configuration
    formatter = {
      name = 'prettier',
      ensure_installed = true,
    },

    -- Treesitter configuration
    treesitter = {
      parsers = { 'css', 'scss' },
    },
  },

  json = {
    -- LSP configuration
    lsp = {
      servers = {
        {
          server = 'jsonls',
          config = {},
        },
        {
          server = 'jsonlint',
          config = {},
        },
      },
    },

    -- Formatter configuration
    formatter = {
      name = 'prettier',
      ensure_installed = true,
    },

    -- Treesitter configuration
    treesitter = {
      parsers = { 'json' },
    },
  },
}