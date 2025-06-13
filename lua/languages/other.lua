return {
  starlark = {
    -- LSP configuration
    lsp = {
      server = 'bzl',
      config = {},
    },

    -- Treesitter configuration
    treesitter = {
      parsers = { 'starlark' },
    },
  },

  sql = {
    -- LSP configuration
    lsp = {
      server = 'sqlls',
      config = {},
    },

    -- Linter configuration
    linter = {
      name = 'sqlfluff',
      ensure_installed = false, -- Commented out in original config
    },

    -- Treesitter configuration
    treesitter = {
      parsers = { 'sql' },
    },
  },

  nginx = {
    -- LSP configuration
    lsp = {
      server = 'nginx_language_server',
      config = {},
    },

    -- Treesitter configuration
    treesitter = {
      parsers = { 'nginx' },
    },
  },

  vim = {
    -- Treesitter configuration
    treesitter = {
      parsers = { 'vim', 'vimdoc' },
    },
  },
}