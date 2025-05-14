-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      ensure_installed = {
        "lua_ls",
        "pyright",
        -- add more arguments for adding more language servers
      },
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      ensure_installed = {
        "stylua",
        "ruff",
        "mypy",
        -- add more arguments for adding more null-ls sources
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      ensure_installed = {
        "python",
        "codelldb", -- Add the LLDB debugger
        "dart",
        "rust_analyzer",
      },
      handlers = {
        python = function(source_name)
          local dap = require "dap"
          dap.adapters.python = {
            type = "executable",
            command = "python3",
            args = { "-m", "debugpy.adapter" },
          }
        end,

        dart = function()
          local dap = require "dap"
          dap.adapters.dart = {
            type = "executable",
            command = "dart",
            args = { "debug_adapter" },
          }

          dap.configurations.dart = {
            {
              name = "Launch Dart Program",
              type = "dart",
              request = "launch",
              program = "${file}",
              cwd = vim.fn.getcwd(),
              args = function()
                local input_str = vim.fn.input("Enter arguments: ", "")
                if input_str == "" then
                  return {} -- No arguments
                end

                -- Manually split input into a table
                local args = {}
                for arg in input_str:gmatch "%S+" do
                  table.insert(args, arg)
                end
                return args
              end,
            },
          }
        end,
      },
    },
  },
}
