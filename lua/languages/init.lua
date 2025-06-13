local M = {}
local config = require('languages.config')

function M.get_lsp_servers()
  local servers = {}
  for _, lang in pairs(config) do
    local lsps = type(lang.lsp) == 'table' and lang.lsp or (lang.lsp and { lang.lsp } or {})
    for _, lsp in ipairs(lsps) do
      servers[lsp] = lang.config or {}
    end
  end
  return servers
end

function M.get_formatters_by_ft()
  local formatters = {}
  for ft, lang in pairs(config) do
    if lang.formatter then
      formatters[ft] = { lang.formatter }
    end
  end
  return formatters
end

function M.get_treesitter_parsers()
  local parsers = {}
  for _, lang in pairs(config) do
    if lang.parsers then
      for _, parser in ipairs(lang.parsers) do
        table.insert(parsers, parser)
      end
    end
  end
  return parsers
end

function M.get_ensure_installed()
  local tools = {}
  for _, lang in pairs(config) do
    if lang.formatter then table.insert(tools, lang.formatter) end
    if lang.dap then table.insert(tools, lang.dap) end
    if lang.tools then
      for _, tool in ipairs(lang.tools) do
        table.insert(tools, tool)
      end
    end
  end
  return tools
end

return M