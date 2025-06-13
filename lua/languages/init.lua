-- Language configuration loader
local M = {}

-- Load all language configurations
function M.load_all()
  local languages = {
    'lua',
    'typescript',
    'python',
    'go',
    'rust',
    'cpp',
    'web',
    'bash',
    'markdown',
    'other',
  }

  local configs = {}
  for _, lang in ipairs(languages) do
    local ok, config = pcall(require, 'languages.' .. lang)
    if ok then
      configs[lang] = config
    else
      vim.notify('Failed to load language config: ' .. lang, vim.log.levels.WARN)
    end
  end

  return configs
end

-- Get LSP servers from all language configs
function M.get_lsp_servers()
  local servers = {}
  local configs = M.load_all()

  for _, config in pairs(configs) do
    -- Handle single language configs
    if config.lsp then
      if config.lsp.server then
        -- Single server
        servers[config.lsp.server] = config.lsp.config or {}
      elseif config.lsp.servers then
        -- Multiple servers
        for _, server_config in ipairs(config.lsp.servers) do
          servers[server_config.server] = server_config.config or {}
        end
      end
    end

    -- Handle multi-language configs (like web.lua)
    for lang_name, lang_config in pairs(config) do
      if type(lang_config) == 'table' and lang_config.lsp then
        if lang_config.lsp.server then
          -- Single server
          servers[lang_config.lsp.server] = lang_config.lsp.config or {}
        elseif lang_config.lsp.servers then
          -- Multiple servers
          for _, server_config in ipairs(lang_config.lsp.servers) do
            servers[server_config.server] = server_config.config or {}
          end
        end
      end
    end
  end

  return servers
end

-- Get formatters from all language configs
function M.get_formatters()
  local formatters = {}
  local configs = M.load_all()

  for _, config in pairs(configs) do
    -- Handle single language configs
    if config.formatter then
      table.insert(formatters, config.formatter.name)
    end

    -- Handle multi-language configs (like web.lua)
    for lang_name, lang_config in pairs(config) do
      if type(lang_config) == 'table' and lang_config.formatter then
        table.insert(formatters, lang_config.formatter.name)
      end
    end
  end

  return formatters
end

-- Get formatters by filetype
function M.get_formatters_by_ft()
  local formatters_by_ft = {}
  local configs = M.load_all()

  -- Map languages to their formatters
  local lang_formatters = {
    lua = configs.lua and configs.lua.formatter and configs.lua.formatter.name,
    python = configs.python and configs.python.formatter and configs.python.formatter.name,
    go = configs.go and configs.go.formatter and configs.go.formatter.name,
    rust = configs.rust and configs.rust.formatter and configs.rust.formatter.name,
    cpp = configs.cpp and configs.cpp.formatter and configs.cpp.formatter.name,
    c = configs.cpp and configs.cpp.formatter and configs.cpp.formatter.name,
    bash = configs.bash and configs.bash.formatter and configs.bash.formatter.name,
    html = configs.web and configs.web.html and configs.web.html.formatter and configs.web.html.formatter.name,
    css = configs.web and configs.web.css and configs.web.css.formatter and configs.web.css.formatter.name,
    json = configs.web and configs.web.json and configs.web.json.formatter and configs.web.json.formatter.name,
    markdown = configs.markdown and configs.markdown.formatter and configs.markdown.formatter.name,
    javascript = configs.typescript and configs.typescript.formatter and configs.typescript.formatter.name,
    typescript = configs.typescript and configs.typescript.formatter and configs.typescript.formatter.name,
    javascriptreact = configs.typescript and configs.typescript.formatter and configs.typescript.formatter.name,
    typescriptreact = configs.typescript and configs.typescript.formatter and configs.typescript.formatter.name,
  }

  for ft, formatter in pairs(lang_formatters) do
    if formatter then
      formatters_by_ft[ft] = { formatter }
    end
  end

  return formatters_by_ft
end

-- Get treesitter parsers from all language configs
function M.get_treesitter_parsers()
  local parsers = {}
  local configs = M.load_all()

  for _, config in pairs(configs) do
    -- Handle single language configs
    if config.treesitter and config.treesitter.parsers then
      for _, parser in ipairs(config.treesitter.parsers) do
        table.insert(parsers, parser)
      end
    end

    -- Handle multi-language configs (like web.lua)
    for lang_name, lang_config in pairs(config) do
      if type(lang_config) == 'table' and lang_config.treesitter and lang_config.treesitter.parsers then
        for _, parser in ipairs(lang_config.treesitter.parsers) do
          table.insert(parsers, parser)
        end
      end
    end
  end

  return parsers
end

-- Get tools to ensure are installed
function M.get_ensure_installed()
  local tools = {}
  local configs = M.load_all()

  for _, config in pairs(configs) do
    -- Handle single language configs
    if config.formatter and config.formatter.ensure_installed then
      table.insert(tools, config.formatter.name)
    end
    if config.linter and config.linter.ensure_installed then
      table.insert(tools, config.linter.name)
    end
    if config.dap and config.dap.ensure_installed then
      table.insert(tools, config.dap.adapter)
    end

    -- Handle multi-language configs
    for lang_name, lang_config in pairs(config) do
      if type(lang_config) == 'table' then
        if lang_config.formatter and lang_config.formatter.ensure_installed then
          table.insert(tools, lang_config.formatter.name)
        end
        if lang_config.linter and lang_config.linter.ensure_installed then
          table.insert(tools, lang_config.linter.name)
        end
        if lang_config.dap and lang_config.dap.ensure_installed then
          table.insert(tools, lang_config.dap.adapter)
        end
      end
    end
  end

  return tools
end

return M