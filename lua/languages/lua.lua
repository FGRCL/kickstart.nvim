return {
  -- LSP configuration
  lsp = {
    server = 'lua_ls',
    config = {
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
          -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
          -- diagnostics = { disable = { 'missing-fields' } },
        },
      },
    },
  },

  -- Formatter configuration
  formatter = {
    name = 'stylua',
    ensure_installed = true,
  },

  -- Treesitter configuration
  treesitter = {
    parsers = { 'lua', 'luadoc' },
  },

  -- DAP configuration (Debug Adapter Protocol)
  dap = {
    -- Lua debugging is typically done through love2d or other specific contexts
    -- Add specific DAP configuration here if needed
  },
}