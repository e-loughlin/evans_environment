return {
  {
    "iamcco/markdown-preview.nvim",
    event = "BufRead **.md",
    config = function()
      vim.fn["mkdp#util#install"]()

      -- Additional configuration options for markdown-preview.nvim
      vim.g.mkdp_auto_start = 1
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 1

      -- Example of setting options within g:mkdp_preview_options
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = 'middle',
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
        toc = {},
      }

      -- Example of setting custom styles
      vim.g.mkdp_markdown_css = '/Users/eloughlin/.config/nvim/styles/air.css'
      -- vim.g.mkdp_highlight_css = '/path/to/custom/highlight.css'

      -- Example of setting other options
      vim.g.mkdp_open_to_the_world = 0
      -- vim.g.mkdp_theme = 'light'
      -- ... add more options as needed ...
    end,
  },
}

