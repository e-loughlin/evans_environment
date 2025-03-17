---@type LazySpec
return {
  -- Gruvbox Material
  {
    "sainnhe/gruvbox-material",
    name = "gruvbox-material",
  },

  -- Catppuccin (Highly customizable and soft pastel colors)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup {
        flavour = "mocha", -- latte, frappe, macchiato, mocha
      }
    end,
  },

  -- Tokyo Night (Dark & vibrant)
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    config = function()
      require("tokyonight").setup {
        style = "moon", -- options: night, storm, moon, day
      }
    end,
  },

  -- Everforest (Calm and natural)
  {
    "sainnhe/everforest",
    name = "everforest",
  },

  -- Nord (Cool and arctic)
  {
    "shaunsingh/nord.nvim",
    name = "nord",
  },

  -- Rose Pine (Elegant and warm)
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup {
        variant = "main", -- main, moon, dawn
      }
    end,
  },

  -- Kanagawa (Inspired by Japanese ink painting)
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
  },

  -- Nightfox (Includes multiple themes: nightfox, nordfox, duskfox, etc.)
  {
    "EdenEast/nightfox.nvim",
    name = "nightfox",
  },
}
