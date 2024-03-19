-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map

    -- navigate buffer tabs with `H` and `L`
    L = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    H = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },

    -- mappings seen under group name "Buffer"
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    ["<leader>mt"] = { "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview Toggle" },
    ["<leader>ms"] = { "<cmd>MarkdownPreviewStop<cr>", desc = "Markdown Preview Stop" },
    ["<leader>mp"] = { "<cmd>MarkdownPreview<cr>", desc = "Markdown Preview" },

    -- ToggleTerm
    ["<C-\\>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    
    ["<leader>tp"] = false,
    ["<leader>tf"] = false,
    ["<leader>th"] = false,
    ["<leader>tv"] = false,
    ["<leader>tn"] = false,
    ["<leader>tu"] = false,
    
    ["<leader>Tf"] = { "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float" },
    ["<leader>Th"] = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "ToggleTerm horizontal split" },
    ["<leader>Tv"] = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "ToggleTerm vertical split" },

    -- ChatGPT
    ["<leader>zz"] = { "<cmd>ChatGPT<cr>", desc = "ChatGPT Chat Window" },
    ["<leader>zr"] = { name = "ChatGPT Run ..." },
    ["<leader>zra"] = { "<cmd>ChatGPTRun add_tests<cr>", desc = "Add Tests" },
    ["<leader>zrC"] = { "<cmd>ChatGPTRun code_readability_analysis<cr>", desc = "Code Readability Analysis" },
    ["<leader>zrc"] = { "<cmd>ChatGPTRun complete_code<cr>", desc = "Complete Code" },
    ["<leader>zrd"] = { "<cmd>ChatGPTRun docstring<cr>", desc = "Docstring" },
    ["<leader>zre"] = { "<cmd>ChatGPTRun explain_code<cr>", desc = "Explain Code" },
    ["<leader>zrf"] = { "<cmd>ChatGPTRun fix_bugs<cr>", desc = "Fix Bugs" },
    ["<leader>zrg"] = { "<cmd>ChatGPTRun grammar_correction<cr>", desc = "Grammar Correction" },
    ["<leader>zrk"] = { "<cmd>ChatGPTRun keywords<cr>", desc = "Keywords" },
    ["<leader>zro"] = { "<cmd>ChatGPTRun optimize_code<cr>", desc = "Optimize Code" },
    ["<leader>zrr"] = { "<cmd>ChatGPTRun roxygen_edit<cr>", desc = "Roxygen Edit" },
    ["<leader>zrs"] = { "<cmd>ChatGPTRun summarize<cr>", desc = "Summarize" },
    ["<leader>zrt"] = { "<cmd>ChatGPTRun translate<cr>", desc = "Translate" },
    ["<leader>zc"] = { "<cmd>ChatGPTCompleteCode<cr>", desc = "ChatGPT Complete Code" },
    ["<leader>za"] = { "<cmd>ChatGPTActAs<cr>", desc = "ChatGPT Act As" },
    ["<leader>ze"] = { "<cmd>ChatGPTEditWithInstructions<cr>", desc = "ChatGPT Edit With Instructions" },
    },
  t = {
    ["<C-\\>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" }
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
