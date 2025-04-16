return {
  "neovim/nvim-lspconfig",

  opts = function(_, opts)
    local telescope = require "telescope.builtin"
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    local on_attach = function(client, bufnr)
      local bufopts = { noremap = true, silent = true, buffer = bufnr }

      -- Enable formatting if supported
      if client.name == "dartls" then client.server_capabilities.documentFormattingProvider = true end

      -- Use Telescope for list-returning LSP features
      vim.keymap.set("n", "gd", telescope.lsp_definitions, bufopts)
      vim.keymap.set("n", "gr", telescope.lsp_references, bufopts)
      vim.keymap.set("n", "gi", telescope.lsp_implementations, bufopts)
      vim.keymap.set("n", "gt", telescope.lsp_type_definitions, bufopts)
      vim.keymap.set("n", "<leader>ls", telescope.lsp_document_symbols, bufopts)
      -- This breaks it:
      -- vim.keymap.set("n", "<leader>lS", telescope.lsp_workspace_symbols, bufopts)

      -- Other LSP features
      vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
      vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, bufopts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_next, bufopts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, bufopts)
      vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, bufopts)
      vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, bufopts)
    end

    -- Set these options for all LSPs
    opts.capabilities = capabilities
    opts.on_attach = on_attach

    -- Override/add Dart-specific config
    local lspconfig = require "lspconfig"
    lspconfig.dartls.setup {
      cmd = { "dart", "language-server", "--protocol=lsp" },
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        dart = {
          sdkPath = "/usr/local/dart-2.19.6",
        },
      },
      root_dir = lspconfig.util.root_pattern("pubspec.yaml", ".git"),
    }
  end,
}
