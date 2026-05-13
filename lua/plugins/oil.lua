return {
    "stevearc/oil.nvim",
    dependencies = { 
      "nvim-tree/nvim-web-devicons",
      {
        "albenisolmos/telescope-oil.nvim",
        dependencies = {
          "nvim-telescope/telescope.nvim"
        },
        config = function ()
          require("telescope").load_extension("oil")
        end
      }
    },
    config = function()
      CustomOilBar = function()
        local path = vim.fn.expand "%"
        path = path:gsub("oil://", "")
        return "  " .. vim.fn.fnamemodify(path, ":.")
      end

      copy_selector = function(state)

        vim.notify(sa)
        local node = state.tree:get_node()
        local filepath = node:get_id()
        local filename = node.name
        local modify = vim.fn.fnamemodify

        local vals = {
          ['BASENAME'] = modify(filename, ':r'),
          ['EXTENSION'] = modify(filename, ':e'),
          ['FILENAME'] = filename,
          ['PATH (CWD)'] = modify(filepath, ':.'),
          ['PATH (HOME)'] = modify(filepath, ':~'),
          ['PATH'] = filepath,
          ['URI'] = vim.uri_from_fname(filepath),
        }

        local options = vim.tbl_filter(function(val)
          return vals[val] ~= ''
        end, vim.tbl_keys(vals))
        if vim.tbl_isempty(options) then
          vim.notify('No values to copy', vim.log.levels.WARN)
          return
        end
        table.sort(options)
        vim.ui.select(options, {
          prompt = 'Choose to copy to clipboard:',
          format_item = function(item)
            return ('%s: %s'):format(item, vals[item])
          end,
        }, function(choice)
          local result = vals[choice]
          if result then
            vim.notify(('Copied: `%s`'):format(result))
            vim.fn.setreg('+', result)
          end
        end)
      end

      require("oil").setup {
        columns = { "icon" },
        keymaps = {
          ["<C-h>"] = false,
          ["<C-l>"] = false,
          ["<C-k>"] = false,
          ["<C-j>"] = false,
          ["<M-h>"] = "actions.select_split",
          ["Y"] = copy_selector,
          ["yp"] = { callback = function()
              local entry = oil.get_cursor_entry()
              local dir = oil.get_current_dir()
              vim.notify(entry, ERROR)
              vim.notify(dir, ERROR)
              if not entry or not dir then
                return
              end
              local relpath = vim.fn.fnamemodify(dir, ":.")
              vim.fn.setreg("+", relpath .. entry.name)
            end,
          },
        },
        win_options = {
          winbar = "%{v:lua.CustomOilBar()}",
        },
        view_options = {
          show_hidden = true,
          is_always_hidden = function(name, _)
            local folder_skip = { "dev-tools.locks", "dune.lock", "_build" }
            return vim.tbl_contains(folder_skip, name)
          end,
        },
      }

      vim.keymap.set("n", "=", "<CMD>Oil<CR>", { desc = "Open parent directory" })
      vim.keymap.set("n", "<leader>=", "<cmd>Telescope oil<CR>", {  desc = 'Search direcotories', noremap = true, silent = true })

      -- Open parent directory in floating window
      -- vim.keymap.set("n", "<space>=", require("oil").toggle_float)
    end,
}
