return {
  -- LSP configuration
  lsp = {
    servers = {
      {
        server = 'clangd',
        config = {},
      },
      {
        server = 'cpplint',
        config = {},
      },
    },
  },

  -- Formatter configuration
  formatter = {
    name = 'clang-format',
    ensure_installed = true,
  },

  -- Linter configuration
  linter = {
    name = 'cpplint',
    ensure_installed = true,
  },

  -- Treesitter configuration
  treesitter = {
    parsers = { 'c', 'cpp' },
  },

  -- DAP configuration
  dap = {
    adapter = 'lldb',
    ensure_installed = true,
  },

  -- Security scanning
  security = {
    name = 'trivy',
    ensure_installed = true,
  },
}