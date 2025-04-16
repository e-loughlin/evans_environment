return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require "telescope.actions"
      local action_state = require "telescope.actions.state"

      -- Define focus_preview function
      local function focus_preview(prompt_bufnr)
        local picker = action_state.get_current_picker(prompt_bufnr)
        local prompt_win = picker.prompt_win
        local previewer = picker.previewer
        local winid = previewer.state.winid
        local bufnr = previewer.state.bufnr

        vim.keymap.set(
          "n",
          "<C-5>", -- CTRL-5 to switch back to the prompt
          function() vim.api.nvim_set_current_win(prompt_win) end,
          { buffer = bufnr }
        )

        vim.api.nvim_set_current_win(winid)
      end

      -- Extend existing mappings
      opts.mappings = opts.mappings or {}
      opts.mappings.i = opts.mappings.i or {}
      opts.mappings.n = opts.mappings.n or {}

      opts.mappings.i["<C-5>"] = focus_preview
      opts.mappings.n["<C-5>"] = focus_preview


      opts.pickers = opts.pickers or {}
      opts.pickers.marks = {
        attach_mappings = function(_, map)
          -- Delete selected mark
          map({ "i", "n" }, "<C-r>", actions.delete_mark)
          return true
        end,
      }

    end,
  },
}

