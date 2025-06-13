return {
  -- LSP configuration
  lsp = {
    servers = {
      {
        server = 'rust-analyzer',
        config = {},
      },
      {
        server = 'ast-grep',
        config = {},
      },
    },
  },

  -- Formatter configuration
  formatter = {
    name = 'ast-grep',
    ensure_installed = true,
  },

  -- Linter configuration
  linter = {
    name = 'clippy',
    ensure_installed = true,
  },

  -- Treesitter configuration
  treesitter = {
    parsers = { 'rust' },
  },

  -- DAP configuration
  dap = {
    adapter = 'lldb',
    ensure_installed = true,
  },
}