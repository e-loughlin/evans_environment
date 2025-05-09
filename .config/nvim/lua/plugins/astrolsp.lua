-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      codelens = true,
      inlay_hints = false,
      semantic_tokens = true,
    },

    formatting = {
      format_on_save = {
        enabled = true,
        allow_filetypes = { "dart" },
        ignore_filetypes = {},
      },
      disabled = {},
      timeout_ms = 1000,
    },

    servers = {
      -- "pyright",
    },

    config = {
      pyright = {
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
        cmd = {
          "clangd",
          "--compile-commands-dir=/Users/eloughlin/ws/polez2",
          "--header-insertion=never", -- optional
          "--clang-tidy",
          "--all-scopes-completion",
        },
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        init_options = {
          clangdFileStatus = true,
        },
      },

      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              extraEnv = { CARGO_PROFILE_RUST_ANALYZER_INHERITS = "dev" },
              extraArgs = { "--profile", "rust-analyzer" },
            },
          },
        },
      },
    },


    handlers = {
      dartls = function(_, opts) require("lspconfig").dartls.setup(opts) end,
    },

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

    -- ✅ Add your custom LSP mappings globally (works with which-key)
    mappings = {
      n = {
        ["gd"] = {
          function() require("telescope.builtin").lsp_definitions() end,
          desc = "Go to definition",
          cond = "textDocument/definition",
        },
        ["gr"] = {
          function() require("telescope.builtin").lsp_references() end,
          desc = "Find references",
          cond = "textDocument/references",
        },
        ["gi"] = {
          function() require("telescope.builtin").lsp_implementations() end,
          desc = "Go to implementation",
          cond = "textDocument/implementation",
        },
        ["gt"] = {
          function() require("telescope.builtin").lsp_type_definitions() end,
          desc = "Type definition",
          cond = "textDocument/typeDefinition",
        },
        ["K"] = {
          function() vim.lsp.buf.hover() end,
          desc = "Hover",
        },
        ["<leader>lr"] = {
          function() vim.lsp.buf.rename() end,
          desc = "Rename symbol",
          cond = "textDocument/rename",
        },
        ["<leader>ld"] = {
          function() vim.diagnostic.open_float() end,
          desc = "Line diagnostics",
        },
        ["[d"] = {
          function() vim.diagnostic.goto_prev() end,
          desc = "Prev diagnostic",
        },
        ["]d"] = {
          function() vim.diagnostic.goto_next() end,
          desc = "Next diagnostic",
        },
        ["<leader>ls"] = {
          function() require("telescope.builtin").lsp_document_symbols() end,
          desc = "Document symbols",
        },
        -- Removed because it fails to work. Default still works.
        -- ["<leader>lS"] = {
        --   function() require("telescope.builtin").lsp_workspace_symbols() end,
        --   desc = "Workspace symbols",
        -- },
      },
      i = {
        ["<C-h>"] = {
          function() vim.lsp.buf.signature_help() end,
          desc = "Signature help",
          cond = "textDocument/signatureHelp",
        },
      },
    },

    -- ✅ Optional: Add extra on_attach logic (not required for mappings above to work)
    on_attach = function(client, bufnr)
      -- You could add custom highlighting or other setup here
    end,
  },
}
