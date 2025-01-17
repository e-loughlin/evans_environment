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

        -- codelldb = function(source_name)
        --   local dap = require "dap"
        --   dap.adapters.lldb = {
        --     type = "executable",
        --     command = "/usr/bin/lldb",
        --     name = "lldb",
        --   }
        --
        --   dap.configurations.cpp = {
        --     {
        --       type = "lldb",
        --       request = "launch",
        --       name = "Launch file with arguments",
        --       program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
        --       args = function()
        --         local args_string = vim.fn.input "Arguments: "
        --         return vim.split(args_string, " +")
        --       end,
        --       cwd = "${workspaceFolder}",
        --       stopOnEntry = false,
        --       runInTerminal = true,
        --     },
        --   }
        --
        --   -- Optionally apply the same configuration to C and Rust
        --   dap.configurations.c = dap.configurations.cpp
        --   dap.configurations.rust = dap.configurations.cpp
        -- end,
      },
    },
  },
}
