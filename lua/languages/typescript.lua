return {
  -- LSP configuration
  lsp = {
    server = 'ts_ls',
    config = {},
  },

  -- Formatter configuration
  formatter = {
    name = 'prettier',
    ensure_installed = true,
  },

  -- Linter configuration
  linter = {
    name = 'eslint',
    ensure_installed = true,
  },

  -- Treesitter configuration
  treesitter = {
    parsers = { 'javascript', 'typescript', 'tsx' },
  },

  -- DAP configuration
  dap = {
    adapter = 'js-debug-adapter',
    ensure_installed = true,
  },
}