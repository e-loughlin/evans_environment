-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
    },

    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright", -- Uncomment this if you're not using Mason to manage the `pyright` server
    },

    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      pyright = {
        on_attach = function(client, bufnr)
          -- Your custom on_attach function can be added here
        end,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        settings = {
          python = {
            analysis = {
              diagnosticSeverityOverrides = {
                reportUnusedExpression = "none",
              },
            },
          },
        },
      },
      clangd = {
        cmd = { "clangd", "--compile-commands-dir=/Users/eloughlin/ws/compile_commands/compile_commands_fea.json" },
      },
    },

    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      dartls = function(_, opts) require("lspconfig").dartls.setup(opts) end,
    },

    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      lsp_codelens_refresh = {
        cond = "textDocument/codeLens",
        {
          event = { "InsertLeave", "BufEnter" },
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
          end,
        },
      },
    },

    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        ["<Leader>uY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client)
            return client.supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
          end,
        },
      },
    },

    -- A custom `on_attach` function to be run after the default `on_attach` function
    on_attach = function(client, bufnr)
      -- Additional customization for on_attach can be placed here
    end,
  },
}
