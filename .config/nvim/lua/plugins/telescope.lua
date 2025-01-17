return {
  -- Customize Telescope mappings
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      -- Modify Telescope mappings here
      local actions = require "telescope.actions"
      local action_state = require "telescope.actions.state"

      -- Add a custom function for focus_preview
      local function focus_preview(prompt_bufnr)
        local picker = action_state.get_current_picker(prompt_bufnr)
        local prompt_win = picker.prompt_win
        local previewer = picker.previewer
        local winid = previewer.state.winid
        local bufnr = previewer.state.bufnr

        vim.keymap.set(
          "n",
          "<C-5>", -- Map CTRL-l to focus the preview
          function() vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", prompt_win)) end,
          { buffer = bufnr }
        )

        vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", winid))
      end

      -- Add custom mappings using the focus_preview function
      opts.mappings = opts.mappings or {}
      opts.mappings.i = opts.mappings.i or {}
      opts.mappings.n = opts.mappings.n or {}

      opts.mappings.i["<C-5>"] = focus_preview
      opts.mappings.n["<C-5>"] = focus_preview
    end,
  },
}
