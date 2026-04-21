return {
  'frankroeder/parrot.nvim',
  dependencies = { 'ibhagwan/fzf-lua', 'nvim-lua/plenary.nvim', 'folke/noice.nvim', 'rcarriga/nvim-notify' },
  enabled = false,
  config = function()
    require('parrot').setup {
      providers = {
        anthropic = {
          name = 'anthropic',
          endpoint = 'https://uai-litellm.internal.unity.com/v1/messages',
          model_endpoint = 'https://uai-litellm.internal.unity.com/v1/models',
          api_key = os.getenv 'ANTHROPIC_API_KEY',
          params = {
            chat = { max_tokens = 128000 },
            command = { max_tokens = 128000 },
          },
          topic = {
            model = 'claude-opus-4-6-v1-engine-eng',
            params = { max_tokens = 128000 },
          },
          -- headers = function(self)
          --   return {
          --     ['Content-Type'] = 'application/json',
          --     ['x-api-key'] = self.api_key,
          --     ['anthropic-version'] = '2023-06-01',
          --   }
          -- end,
          models = {
            'anthropic.claude-sonnet-4-6-engine-eng',
            'claude-haiku-4-5-20251001-engine-eng',
            'claude-opus-4-6-v1-engine-eng',
          },
          preprocess_payload = function(payload)
            for _, message in ipairs(payload.messages) do
              message.content = message.content:gsub('^%s*(.-)%s*$', '%1')
            end
            if payload.messages[1] and payload.messages[1].role == 'system' then
              -- remove the first message that serves as the system prompt as anthropic
              -- expects the system prompt to be part of the API call body and not the messages
              payload.system = payload.messages[1].content
              table.remove(payload.messages, 1)
            end
            return payload
          end,
        },
      },
      preview_border = 'solid',
      preview_max_width = 360,
      preview_max_height = 90,
    }

    vim.keymap.set('v', '<leader>pi', ':PrtImplement<cr>', { desc = 'Parrot trigger code completions based on comments' })
    vim.keymap.set('v', '<leader>pr', ':PrtRewrite<cr>', { desc = 'Parrot rewrite a visual selection' })
    vim.keymap.set('v', '<leader>pa', ':PrtAppend<cr>', { desc = 'Parrot append code to the visual selection' })
    vim.keymap.set('v', '<leader>pp', ':PrtPrepend<cr>', { desc = 'Parrot prerpend code to the visual selectionh' })
  end,
}
