-- set leader key
vim.g.mapleader = " "

--remap horizontal buffer split
vim.keymap.set("n", "<leader>bh", "<cmd>split<CR>")

-- remap vertical buffer split
vim.keymap.set("n", "<leader>bv", "<cmd>vsplit<CR>")

-- remap jump-to-end-of-line
vim.keymap.set({"n", "v"}, "<leader>nd", "$")

--remap jump-to-start-of-line
vim.keymap.set({"n","v"}, "<leader>st", "^")

-- remap redo key to "r"
vim.keymap.set("n", "r", vim.cmd.redo, {noremap = true})

-- remap ctrl-w buffer switcher
vim.keymap.set("n", "<leader>w", "<C-w>")

-- remap tag return Ctrl-t for "go back from definition"
vim.keymap.set("n", "gb", "<C-t>")

-- remap vim's "Ex" Netrw explorer cmd in normal mode
vim.keymap.set("n", "<leader>ee", vim.cmd.Ex)

-- remapping for Visual Block mode
vim.keymap.set({"n", "v"}, "<leader>vv", "<C-v>")

-- when highlighting in visual mode, you can move the entire highlighted
-- sections with capital J, K, L, H
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("x", "L", ">gv")
vim.keymap.set("x", "H", "<gv")

-- append the line below the curr line to the curr line with a space in btw
vim.keymap.set("n", "J", "mzJ`z")

--  ctrl-d and ctrl-u are for half-page jumping down/up respectively,
--  but these next cmds make it so that the cursor stays in the middle of the
--  page when you do these jumps
vim.keymap.set("n", "<leader>l", "<C-d>zz")
vim.keymap.set("n", "<leader>h", "<C-u>zz")

-- these will keep the cursor in the middle of the page when jumping btw
-- search terms
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- these next 2 are just for Twitch and Prime doesn't say why 
vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- this is for pasting the curr yanked item into some 2nd item to replace
-- that 2nd item. This makes it so that the curr yanked item stays in that
-- yanked buffer after you replace any item with it
-- if you just use p for replace, that 2nd item would then be in the buffer
vim.keymap.set("x", "<leader>p", [["_dP]])

-- y will yank only within Vim, but now leader-y will yank to system Clipboard 
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- I actually can't tell what this does
-- vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- don't allow Q to be pressed with "no press"
vim.keymap.set("n", "Q", "<nop>")

-- these were for opening up a new tmux session
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- these next 4 are for quick-fix navigation in Vim
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- this will allow you to replace ALL instances of the word that the cursor
-- was currently on when you pressed this cmd
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- turn the curr file into an executable 
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- I don't know what this cmd does
-- vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>");

-- this is a plugin which makes useless animations in Vim
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");
vim.keymap.set("n", "<leader>gl", "<cmd>CellularAutomaton game_of_life<CR>");

-- this is for :so %  which is "source curr NeoVim config file"
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("luafile $MYVIMRC")
end)

-- these next 2 are for trouble plugin
vim.keymap.set("n", "<leader>qf", "<cmd>TroubleToggle quickfix<cr>",
  {silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>tt", "<cmd>Trouble<CR>")





