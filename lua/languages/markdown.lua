return {
  -- LSP configuration
  lsp = {
    servers = {
      {
        server = 'vale',
        config = {},
      },
      {
        server = 'harper-ls',
        config = {
          filetypes = { 'markdown' },
        },
      },
    },
  },

  -- Formatter configuration
  formatter = {
    name = 'prettier',
    ensure_installed = true,
  },

  -- Linter configuration
  linter = {
    name = 'vale',
    ensure_installed = true,
  },

  -- Treesitter configuration
  treesitter = {
    parsers = { 'markdown', 'markdown_inline' },
  },

  -- Preview tool
  preview = {
    name = 'glow',
    ensure_installed = true,
  },
}