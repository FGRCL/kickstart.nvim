return {
  -- LSP configuration
  lsp = {
    servers = {
      {
        server = 'bashls',
        config = {},
      },
      {
        server = 'shellcheck',
        config = {},
      },
    },
  },

  -- Formatter configuration
  formatter = {
    name = 'shellharden',
    ensure_installed = true,
  },

  -- Linter configuration
  linter = {
    name = 'shellcheck',
    ensure_installed = true,
  },

  -- Treesitter configuration
  treesitter = {
    parsers = { 'bash' },
  },

  -- DAP configuration
  dap = {
    -- Bash debugging is typically done through shell specific tools
    -- Add specific DAP configuration here if needed
  },
}