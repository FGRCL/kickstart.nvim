return {
  -- LSP configuration
  lsp = {
    server = 'gopls',
    config = {},
  },

  -- Formatter configuration
  formatter = {
    name = 'gofmt',
    ensure_installed = true,
  },

  -- Linter configuration
  linter = {
    name = 'golangci-lint',
    ensure_installed = true,
  },

  -- Treesitter configuration
  treesitter = {
    parsers = { 'go', 'gomod', 'gowork' },
  },

  -- DAP configuration
  dap = {
    adapter = 'delve',
    ensure_installed = true,
  },
}