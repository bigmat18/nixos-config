vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- exit from insert mode
vim.keymap.set("i", "jk", "<ESC>")

-- mov up and down the section selected
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- mov when search something
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- clear search highlights
vim.keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("x", "x", '"_x')

-- in visual mode paste over the selected section withour copy the text
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "XX", '"_dd', { noremap = true })

-- go to next and prev error
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- save all open files
vim.keymap.set("n", "<leader>s", "<cmd>wa<CR>", { noremap = true})

-- reload all files
vim.keymap.set("n", "<leader>r", "<cmd>bufdo e!<CR>")

-- the word under curse will be replace
vim.keymap.set("n", "<leader>c", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- remove Q in normal mode (it enter in ex mode, useless)
vim.keymap.set("n", "Q", "<nop>")

-- open a new tmus window
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- format document
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- window management
vim.keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

vim.keymap.set('n', '<A-h>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<A-l>', ':vertical resize +2<CR>')
vim.keymap.set('n', '<A-j>', ':resize -2<CR>')
vim.keymap.set('n', '<A-k>', ':resize +2<CR>')

vim.keymap.set("n", "<leader>to", ":tabnew %<CR>") -- open new tab
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
vim.keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- increment/decrement numbers
vim.keymap.set("n", "<leader>+", "<C-a>") -- increment
vim.keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- vim-maximizer
vim.keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- telescope keybinding
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope git_files<cr>") -- list available help tags

-- nvim-tree keybinding
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explor
vim.keymap.set("n", "<leader>z", function()
  require("zen-mode").toggle()
end, { desc = "Toggle Zen Mode" })