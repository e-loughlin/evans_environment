return {
  "epwalsh/obsidian.nvim",
  lazy = true,
  event = { "BufReadPre /Users/eloughlin/ws/journal/**.md" },
  -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
  -- event = { "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md" },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    dir = "~/ws/journal",  -- no need to call 'vim.fn.expand' here
    mappings = {},
    -- see below for full list of options 👇
  },
}
