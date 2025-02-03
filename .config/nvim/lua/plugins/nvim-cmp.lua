-- Set up nvim-cmp with Copilot integration
return {
  {
    "hrsh7th/nvim-cmp", -- nvim-cmp plugin
    event = "InsertEnter",
    config = function()
      local cmp = require "cmp"

      cmp.setup {
        mapping = {
          -- Use <C-CR> (Ctrl + Enter) to accept Copilot suggestion
          ["<C-CR>"] = cmp.mapping(function(fallback)
            -- Trigger Copilot's accept action using <CR> (Enter)
            vim.api.nvim_feedkeys(
              vim.fn["copilot#Accept"](vim.api.nvim_replace_termcodes("<CR>", true, true, true)),
              "n",
              true
            )
          end),

          -- Other mappings for nvim-cmp
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
        },
        sources = {
          { name = "copilot" }, -- Add Copilot as a source for nvim-cmp
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        },
        experimental = {
          ghost_text = false, -- Disable ghost text (conflicts with Copilot preview)
        },
      }
    end,
  },
}
