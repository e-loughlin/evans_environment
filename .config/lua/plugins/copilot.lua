return {
  {
    "github/copilot.vim",
    lazy = false, -- Load immediately on startup
    config = function()
      vim.g.copilot_node_command = "/Users/eloughlin/.nvm/versions/node/v18.20.5/bin/node"
      -- You can add custom settings here if needed
      -- vim.g.copilot_no_tab_map = true -- Example: Disable default tab mappings
      -- Set your key mappings
      -- vim.api.nvim_set_keymap("i", "<C-c>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end,
  },
}
