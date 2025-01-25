-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)
local js_based_languages = {
  'typescript',
  'typescriptreact',
  'javascript',
  'javascriptreact',
}

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'mxsdev/nvim-dap-vscode-js',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
        'js-debug-adapter',
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }

    -- setup adapters
    require('dap-vscode-js').setup {
      -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
      -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
      debugger_cmd = { 'js-debug-adapter' }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
      -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
      -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
      -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
    }

    -- dap.adapters['pwa-node'] = {
    --   type = 'server',
    --   host = 'localhost',
    --   port = '${port}',
    --   executable = {
    --     command = 'js-debug-adapter',
    --     args = { '${port}' },
    --   },
    -- }
    --
    -- dap.adapters['pwa-chrome'] = {
    --   type = 'server',
    --   host = 'localhost',
    --   port = '${port}',
    --   executable = {
    --     command = 'node',
    --     args = {
    --       require('mason-registry').get_package('js-debug-adapter'):get_install_path() .. '/js-debug/src/dapDebugServer.js',
    --       '${port}',
    --     },
    --   },
    -- }
    -- dap.adapters.chrome = {
    --   type = 'executable',
    --   command = 'node',
    --   args = { os.getenv 'HOME' },
    -- }

    -- dap.configurations.javascript = {
    --   type = 'pwa-node',
    --   request = 'launch',
    --   name = 'Launch file',
    --   program = '${file}',
    --   cwd = '${workspaceFolder}',
    -- }

    -- custom adapter for running tasks before starting debug
    --   dap.configurations.javascript = {
    --   }
    --   local custom_adapter = 'pwa-node-custom'
    --   dap.adapters[custom_adapter] = function(cb, config)
    --     if config.preLaunchTask then
    --       local async = require 'plenary.async'
    --       local notify = require('notify').async
    --
    --       async.run(function()
    --         ---@diagnostic disable-next-line: missing-parameter
    --         notify('Running [' .. config.preLaunchTask .. ']').events.close()
    --       end, function()
    --         vim.fn.system(config.preLaunchTask)
    --         config.type = 'pwa-node'
    --         dap.run(config)
    --       end)
    --     end
    --   end
    --
    --   require('dap.ext.vscode').load_launchjs()
    --
    for _, language in ipairs(js_based_languages) do
      dap.configurations[language] = {
        {
          name = 'Launch',
          type = 'pwa-node',
          request = 'launch',
          program = '${file}',
          rootPath = '${workspaceFolder}',
          cwd = '${workspaceFolder}',
          sourceMaps = true,
          skipFiles = { '<node_internals>/**' },
          protocol = 'inspector',
          console = 'integratedTerminal',
        },
        {
          name = 'Attach to node process',
          type = 'pwa-node',
          request = 'attach',
          rootPath = '${workspaceFolder}',
          processId = require('dap.utils').pick_process,
        },
        {
          name = 'Debug Main Process',
          type = 'pwa-node',
          request = 'launch',
          command = 'npm run dev',
          cwd = '${workspaceFolder}/frontend',
          env = {
            REMOTE_DEBUGGING_PORT = '9222',
            VSCODE_DEBUG = 'true',
          },
        },
        {
          name = 'Debug Renderer Process',
          type = 'chrome',
          request = 'attach',
          port = 9222,
          webRoot = '${workspaceFolder}/frontend/src',
          timeout = 30000,
        },
      }
    end
  end,
  -- keys = {
  --   {
  --     '<leader>da',
  --     function()
  --       if vim.fn.filereadable '.vscode/launch.json' then
  --         local dap_vscode = require 'dap.ext.vscode'
  --         dap_vscode.load_launchjs(nil, {
  --           ['pwa-node'] = js_based_languages,
  --           ['chrome'] = js_based_languages,
  --           ['pwa-chrome'] = js_based_languages,
  --         })
  --       end
  --       require('dap').continue()
  --     end,
  --     desc = 'Run with Args',
  --   },
  -- },
}
