return {
  "goolord/alpha-nvim",

  dependencies = {
    "ozthemagician/alpha-cowsays-nvim",
    "BlakeJC94/alpha-nvim-fortune",
  },
  opts = function(_, opts) -- override the options using lazy.nvim
    opts.section.header.val = { -- change the header section value
      "                              ",
      "                              ",
      "⠀⣀⣀⣀⡀⠀⠀⠀⠀⣀⣤⣶⣶⣾⣿⣿⣿⣷⣶⣶⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀",
      "⣾⣿⠛⠛⠛⠛⢶⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⠀⠀⠀⠀⠀",
      "⢹⣿⡀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠉⠛⣿⣷⣄⠀⠀⠀",
      "⠀⢻⣷⣀⣾⣿⡟⠁⠀⠀⠈⠙⢿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⣸⣿⣿⣆⠀⠀",
      "⠀⠀⠙⠁⠻⣿⣿⣿⣿⣦⣄⠀⠀⠙⢿⣿⣿⣿⣄⠀⠀⢀⠠⠊⠀⠀⠹⣿⡇⠀",
      "⠀⠀⢰⣷⡄⠈⢿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠉⠛⢿⣶⡖⠁⠀⠀⠀⢀⣴⣿⣿⠀",
      "⠀⠀⣾⣿⣿⣦⡀⠙⢿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠹⣷⣄⠀⣠⠔⠛⠻⣿⣿⡇",
      "⠀⠀⢻⣿⣿⣿⣿⣦⡀⠙⢿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠹⣿⣟⠁⠀⠀⠀⣽⣿⠃",
      "⠀⠀⠘⣿⣿⣿⣿⣿⣿⣦⡀⠉⠻⡿⠁⠀⠀⠀⠀⠀⠀⣿⣿⣦⣤⣤⣾⣿⡟⠀",
      "⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⠷⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⠃⠀",
      "⠀⠀⠀⠀⠙⢿⣿⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⡿⢻⡄⠀",
      "⠀⠀⠀⠀⠀⠈⠻⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⢿⣿⣿⡿⠋⠀⠀⢻⡄",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣿⣷⣦⡄⣨⣯⣄⡀⠀⠀⢀⣿",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠛⠛⠋⠉⠀⠀⠀⠉⠙⠻⠿⠿⠿⠋",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⣶⣶⡶⢶⣶⣤⡀⢠⣴⣶⠿⢶⣦⣄⢰⣶⣶⣄⠀⣶⣶⠀⣶⡆⣶⣶⣶⣶⣶⣶",
      "⣿⣿⡇⠀⣹⣿⡇⣿⣿⡇⠀⢀⣿⣿⢸⣿⡿⢿⣷⣿⣿⠀⠿⠇⠀⠀⣿⣿⠀⠀",
      "⠿⠿⠷⠿⠿⠋⠀⠈⠻⠿⠶⠿⠟⠋⠸⠿⠇⠀⠙⠿⠿⠀⠀⠀⠀⠀⠿⠿⠀⠀",
      "⣤⣶⣶⣶⣤⣄⠀⢠⣶⣶⡄⠀⢠⣴⣤⡄⠀⣴⣶⠀⣴⣶⡄⢀⣤⣶⣶⣦⣄⡀",
      "⣿⣿⣧⣤⣿⡿⢣⣾⡟⢻⣿⡄⢸⣿⡿⢿⣦⣿⣿⠀⣿⣿⣷⣿⣿⠁⠀⠙⠛⠃",
      "⠿⠿⠏⠉⠁⠀⠾⠿⠛⠛⠿⠿⠼⠿⠷⠀⠻⠿⠿⠀⠿⠿⠇⠙⠿⣷⣶⡿⠿⠃",
    }

    -- opts.section.header.opts = { hl = { { "GreenHLGroup", 0, 12 }, { "BlueHLGroup", 13, 20 } } }
    --     -- Possible options: Function, String, Number, Keyword, Identifier...
    opts.section.header.opts.hl = "Identifier"
    opts.section.footer.opts.hl = "Identifier"

    -- local cow = require "alpha-cowsays-nvim"
    --
    -- local fortune = require "alpha.fortune"
  end,
}
