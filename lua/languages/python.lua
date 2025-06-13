return {
  -- LSP configuration
  lsp = {
    servers = {
      {
        server = 'pylsp',
        config = {
          -- settings = {
          --   pylsp = {
          --     plugins = {
          --       pylint = { enabled = true },
          --     },
          --   },
          -- },
        },
      },
      {
        server = 'pyright',
        config = {},
      },
      {
        server = 'ruff',
        config = {},
      },
    },
  },

  -- Formatter configuration
  formatter = {
    name = 'ruff',
    ensure_installed = true,
  },

  -- Linter configuration
  linter = {
    name = 'ruff',
    ensure_installed = true,
  },

  -- Treesitter configuration
  treesitter = {
    parsers = { 'python' },
  },

  -- DAP configuration
  dap = {
    adapter = 'debugpy',
    ensure_installed = true,
  },
}