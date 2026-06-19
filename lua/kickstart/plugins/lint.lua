return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      -- getArgs() in golangcilint.lua determines filename_modifier once at module load
      -- using `go env GOMOD` in nvim's cwd. nvim-lint evaluates arg functions via
      -- with_cwd(vim.fn.getcwd()), so re-running go env GOMOD in a lambda has the same
      -- problem. Use findfile instead — it searches upward from the buffer's own directory
      -- and is cwd-independent.
      local golangcilint = require('lint').linters.golangcilint
      if golangcilint and golangcilint.args then
        for i, arg in ipairs(golangcilint.args) do
          if type(arg) == 'function' then
            golangcilint.args[i] = function()
              local bufname = vim.api.nvim_buf_get_name(0)
              local bufdir = vim.fn.fnamemodify(bufname, ':h')
              local gomod = vim.fn.findfile('go.mod', bufdir .. ';')
              return vim.fn.fnamemodify(bufname, gomod ~= '' and ':h' or ':p')
            end
            break
          end
        end
      end

      lint.linters_by_ft = {
        markdown = { 'vale' },
        javascript = { 'eslint' },
        javascriptreact = { 'eslint' },
        typescript = { 'eslint' },
        typescriptreact = { 'eslint' },
        json = { 'jsonlint' },
        html = { 'erb_lint' },
        css = { 'stylelint' },
        python = { 'ruff' },
        bash = { 'shellharden' },
        cpp = { 'cpplint' },
        cmake = { 'cmakelint' },
        go = { 'golangcilint' },
        lua = { 'selene' },
        protobuf = { 'buf_ls' },
      }

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      -- lint.linters_by_ft['clojure'] = nil
      -- lint.linters_by_ft['dockerfile'] = nil
      -- lint.linters_by_ft['inko'] = nil
      -- lint.linters_by_ft['janet'] = nil
      -- lint.linters_by_ft['json'] = nil
      -- lint.linters_by_ft['markdown'] = nil
      -- lint.linters_by_ft['rst'] = nil
      -- lint.linters_by_ft['ruby'] = nil
      -- lint.linters_by_ft['terraform'] = nil
      -- lint.linters_by_ft['text'] = nil

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },
}
