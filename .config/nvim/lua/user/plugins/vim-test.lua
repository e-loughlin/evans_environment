-- vim-test keybindings
vim.api.nvim_set_keymap("n", "<leader>tt", ":TestNearest<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tT", ":TestFile<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ta", ":TestSuite<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tl", ":TestLast<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tg", ":TestVisit<CR>", { noremap = true, silent = true })

return {
  -- Vim-Test settings
  {
    "vim-test/vim-test",
    event = "User AstroFile",
    config = function() vim.cmd "source ~/.config/nvim/lua/user/plugins/vimtest_extra_config.vim" end,
  },
}
