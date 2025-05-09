-- plugins/community.lua
return {
  -- This enables AstroCommunity support
  { "AstroNvim/astrocommunity" },

  -- Add the desired language packs below
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.lua" },
}

