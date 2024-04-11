vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true
-- vim.keymap.set("n", "<leader>e", vim.cmd.Ex) Added nvim-tree

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- vim-tmux navigator is needed to connect to tmux
--vim.keymap.set("n", "<C-j>", [[:wincmd j<CR>]])
--vim.keymap.set("n", "<C-k>", [[:wincmd k<CR>]])
--vim.keymap.set("n", "<C-l>", [[:wincmd l<CR>]])
--vim.keymap.set("n", "<C-h>", [[:wincmd h<CR>]])
