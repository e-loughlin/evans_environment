return {
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto", "markdown" }, -- Load only for Quarto and Markdown filetypes
    dependencies = {
      { "jmbuhr/otter.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = function()
      require("quarto").setup {
        debug = false,
        closePreviewOnExit = true,
        lspFeatures = {
          enabled = true,
          chunks = "all",
          languages = { "r", "python", "julia", "bash", "html" },
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        codeRunner = {
          enabled = true,
          default_method = "molten", -- "molten", "slime", "iron" or <function>
          ft_runners = {}, -- Filetype to runner mapping
          never_run = { "yaml" }, -- Filetypes never sent to a runner
        },
      }
    end,
  },
}
