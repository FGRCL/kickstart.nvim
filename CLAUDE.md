# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a customized Neovim configuration based on kickstart.nvim, extended with additional plugins for enhanced development experience. The configuration uses Lua and the lazy.nvim plugin manager.

## Architecture

### Plugin Management
- **lazy.nvim**: Plugin manager that handles all plugin installations and lazy loading
- Plugin configurations are split between:
  - `init.lua`: Core kickstart plugins and LSP setup
  - `lua/kickstart/plugins/`: Kickstart-specific plugin configurations  
  - `lua/plugins/`: Custom plugin additions
  - `lua/languages/`: Language-specific configurations (NEW)

### Language Configuration System
This configuration uses a modular language system where each language has its own configuration file in `lua/languages/`:

- **lua/languages/init.lua**: Language loader and utilities
- **lua/languages/lua.lua**: Lua LSP, formatter, and treesitter config
- **lua/languages/typescript.lua**: TypeScript/JavaScript configuration
- **lua/languages/python.lua**: Python configuration with multiple LSP servers
- **lua/languages/go.lua**: Go development configuration
- **lua/languages/rust.lua**: Rust configuration
- **lua/languages/cpp.lua**: C++ configuration
- **lua/languages/web.lua**: HTML, CSS, and JSON configurations
- **lua/languages/bash.lua**: Shell scripting configuration
- **lua/languages/markdown.lua**: Markdown and documentation configuration
- **lua/languages/other.lua**: Specialized languages (Starlark, SQL, Nginx, etc.)

Each language file contains:
- **LSP**: Language server configurations
- **Formatter**: Code formatting tools
- **Linter**: Code linting tools
- **Treesitter**: Syntax highlighting parsers
- **DAP**: Debug adapter protocol setup

### LSP and Language Support
- **Mason**: Automatic LSP server installation and management
- **nvim-lspconfig**: LSP client configurations loaded from language files
- **conform.nvim**: Code formatting with formatters defined per language
- **nvim-cmp**: Autocompletion with LSP integration

Supported languages include: Go, TypeScript/JavaScript, Python, Lua, Rust, C++, HTML/CSS, JSON, Bash, and more.

### Key Plugin Categories
- **Telescope**: Fuzzy finder for files, symbols, and live grep
- **Treesitter**: Syntax highlighting and code parsing
- **Neo-tree**: File explorer
- **Gitsigns**: Git integration and signs
- **Which-key**: Keybinding discovery
- **AI Integration**: Claude Code plugin and LLM support (disabled by default)

## Key Keybindings

### Leader Key
- Space (` `) is the leader key

### Core Navigation
- `<leader>sf`: Search files
- `<leader>sg`: Live grep
- `<leader>sh`: Search help
- `<leader><leader>`: Find buffers
- `<leader>sn`: Search Neovim config files

### LSP Functions
- `gd`: Go to definition
- `gr`: Go to references  
- `K`: Hover documentation
- `<leader>ca`: Code actions
- `<leader>rn`: Rename symbol
- `<leader>f`: Format buffer

### File Operations
- `<leader>ww`: Save current buffer
- `<leader>wa`: Save all buffers

## Development Commands

### Plugin Management
```lua
:Lazy          -- Open plugin manager
:Lazy update   -- Update all plugins
:Lazy install  -- Install missing plugins
```

### LSP Management
```lua
:Mason         -- Open Mason for LSP server management
:LspInfo       -- Show LSP client information
:checkhealth   -- Check Neovim health including LSP setup
```

### Formatting
The configuration uses conform.nvim with these formatters:
- Lua: stylua
- Python: ruff
- HTML/CSS: prettier
- Rust: ast-grep
- C++: clang-format
- Bash: shellharden

## Configuration Structure

### Main Files
- `init.lua`: Core configuration and plugin setup
- `lazy-lock.json`: Plugin version lock file (don't edit manually)

### Plugin Directories
- `lua/kickstart/plugins/`: Core kickstart plugin configurations
- `lua/plugins/`: Custom plugin additions and overrides
- `lua/languages/`: Language-specific configurations (NEW)

### Adding New Languages
To add support for a new language:

1. Create a new file in `lua/languages/` (e.g., `java.lua`)
2. Follow the structure of existing language files:
   ```lua
   return {
     lsp = {
       server = 'jdtls',
       config = {}
     },
     formatter = {
       name = 'google-java-format',
       ensure_installed = true
     },
     treesitter = {
       parsers = { 'java' }
     },
     dap = {
       adapter = 'java-debug-adapter',
       ensure_installed = true
     }
   }
   ```
3. Add the language name to the `languages` list in `lua/languages/init.lua`
4. Restart Neovim to load the new configuration

### Custom Plugins
Notable custom plugins include:
- **telescope.lua**: Enhanced fuzzy finding with custom keybindings
- **claudecode.lua**: Claude Code integration
- **llm.lua**: LLM support (currently disabled)
- **leetcode.lua**: LeetCode integration
- **trouble.lua**: Diagnostics and error management

## Colorscheme

Uses automatic dark/light mode switching with:
- Dark mode: Catppuccin Mocha
- Light mode: Catppuccin Frappe
- Fallback: Gruvbox theme available

## Dependencies

External tools that should be installed:
- **ripgrep**: For telescope live grep
- **fd**: For better file finding
- **make**: For telescope-fzf-native compilation
- **git**: Version control
- **Node.js/npm**: For TypeScript/JavaScript development
- **Go**: For Go development
- **Python**: For Python development

## Do not write comments