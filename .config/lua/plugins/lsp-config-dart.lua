return {
  "neovim/nvim-lspconfig",

  opts = function(_, opts)
    local lspconfig = require "lspconfig"
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- Define an on_attach function
    local on_attach = function(client, bufnr)
      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
      vim.keymap.set("n", "<leader>lw", vim.lsp.buf.workspace_symbol, bufopts)
      vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, bufopts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_next, bufopts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, bufopts)
      vim.keymap.set("n", "<leader>lR", vim.lsp.buf.references, bufopts)
      vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, bufopts)
      vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, bufopts)
    end

    -- Merge dartls configuration with shared opts
    lspconfig.dartls.setup(vim.tbl_deep_extend("force", opts, {
      cmd = { "dart", "language-server", "--protocol=lsp" },
      on_attach = on_attach,
      capabilities = capabilities,
    }))
  end,
}
