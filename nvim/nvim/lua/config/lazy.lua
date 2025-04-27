-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- if you have a nerd font installed, set to true
vim.g.have_nerd_font = true

-- keep cursor big in insert mode
vim.opt.guicursor = ""

-- lines numbers and relative line numbers
vim.opt.nu = true
vim.opt.relativenumber = false

-- case insensitive searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

--  4-space indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- turn off line wrapping
vim.opt.wrap = false

-- stop vim from auto-backups
vim.opt.swapfile = false
vim.opt.backup = false

-- store undos in here for long-term undo storage
-- then you can find undos from days ago
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- turn off highlights on search
vim.opt.hlsearch = false

-- this is "incremental search" and it helps find tricky searches and
-- also wild-card searches with * just like Bash does
vim.opt.incsearch = true

-- Add these global transparency settings after the Lazy setup
vim.opt.winblend = 0      -- Enable window transparency
vim.opt.pumblend = 0      -- Enable popup menu transparency
vim.opt.termguicolors = true -- Enable true color support
-- this sets the background to transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })

-- this sets the numbers below the curr line to start again from 1
-- and it makes sure that there are at least 8 more nums listed
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- fast update times
vim.opt.updatetime = 50

-- set color strip in col 80
-- vim.opt.colorcolumn = "80"

-- get rid of nvim auto-comments
vim.cmd([[autocmd FileType * set formatoptions-=ro]])

-- global remaps

--remap horizontal buffer split
vim.keymap.set("n", "<leader>bh", "<cmd>split<CR>", { desc = "Lazy Config: Split buffer horizontally" })

-- remap vertical buffer split
vim.keymap.set("n", "<leader>bv", "<cmd>vsplit<CR>", { desc = "Lazy Config: Split buffer vertically" })

-- remap jump-to-end-of-line
vim.keymap.set({ "n", "v" }, "<leader>nd", "$", { desc = "Lazy Config: Jump to end of line" })

--remap jump-to-start-of-line
vim.keymap.set({ "n", "v" }, "<leader>st", "^", { desc = "Lazy Config: Jump to start of line" })

-- remap redo key to "r"
vim.keymap.set("n", "r", vim.cmd.redo, { noremap = true, desc = "Lazy Config: Redo last action" })

-- remap ctrl-w buffer switcher
vim.keymap.set("n", "<leader>w", "<C-w>", { desc = "Lazy Config: Window commands prefix" })

-- remap tag return Ctrl-t for "go back from definition"
vim.keymap.set("n", "gb", "<C-t>", { desc = "Lazy Config: Go back from definition" })

-- remap vim's "Ex" Netrw explorer cmd in normal mode
vim.keymap.set("n", "<leader>ee", vim.cmd.Ex, { desc = "Lazy Config: Open Netrw file explorer" })

-- remapping for Visual Block mode
vim.keymap.set({ "n", "v" }, "<leader>vv", "<C-v>", { desc = "Lazy Config: Enter Visual Block mode" })

-- when highlighting in visual mode, you can move the entire highlighted
-- sections with capital J, K, L, H
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Lazy Config: Move selected text down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Lazy Config: Move selected text up" })
vim.keymap.set("x", "L", ">gv", { desc = "Lazy Config: Indent selection right" })
vim.keymap.set("x", "H", "<gv", { desc = "Lazy Config: Indent selection left" })

-- append the line below the curr line to the curr line with a space in btw
vim.keymap.set("n", "J", "mzJ`z", { desc = "Lazy Config: Join line below with current line" })

--  ctrl-d and ctrl-u are for half-page jumping down/up respectively,
--  but these next cmds make it so that the cursor stays in the middle of the
--  page when you do these jumps
vim.keymap.set("n", "<leader>ll", "<C-d>zz", { desc = "Lazy Config: Half-page jump down" })
vim.keymap.set("n", "<leader>hh", "<C-u>zz", { desc = "Lazy Config: Half-page jump up" })

-- these will keep the cursor in the middle of the page when jumping btw
-- search terms
vim.keymap.set("n", "n", "nzzzv", { desc = "Lazy Config: Next search result centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Lazy Config: Previous search result centered" })

-- this is for pasting the curr yanked item into some 2nd item to replace
-- that 2nd item. This makes it so that the curr yanked item stays in that
-- yanked buffer after you replace any item with it
-- if you just use p for replace, that 2nd item would then be in the buffer
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Lazy Config: Paste without yanking replaced text" })

-- y will yank only within Vim, but now leader-y will yank to system Clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Lazy Config: Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Lazy Config: Yank line to system clipboard" })

-- Visual mode mapping: Delete and copy to system clipboard
vim.keymap.set("v", "<leader>dd", '"+d', { noremap = true, silent = true, desc = "Lazy Config: Delete and copy to system clipboard" })

-- don't allow Q to be pressed with "no press"
vim.keymap.set("n", "Q", "<nop>", { desc = "Lazy Config: Disable Ex mode" })

-- these next 4 are for quick-fix navigation in Vim
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Lazy Config: Next quickfix item" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Lazy Config: Previous quickfix item" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Lazy Config: Next location list item" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Lazy Config: Previous location list item" })

-- this will allow you to replace ALL instances of the word that the cursor
-- was currently on when you pressed this cmd
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Lazy Config: Replace word under cursor" })

-- turn the curr file into an executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Lazy Config: Make current file executable" })

-- this is for :so %  which is "source curr NeoVim config file"
vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("luafile $MYVIMRC")
end, { desc = "Lazy Config: Source current Neovim config file" })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Setup diagnostic toggle state and config
local diagnostics_enabled = false
vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        header = "",
        prefix = "",
    },
})

-- Toggle All Diagnostics keymap
vim.keymap.set("n", "<leader>dt", function()
    if diagnostics_enabled then
        vim.diagnostic.config({ virtual_text = false })
        print("Diagnostics text disabled")
    else
        vim.diagnostic.config({ virtual_text = true })
        print("Diagnostics text enabled")
    end
    diagnostics_enabled = not diagnostics_enabled
end, { desc = "Lazy Config: Toggle all diagnostic text" })


-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    ui = {  -- Remove the extra curly brace that was here
        border = "rounded",
        winblend = 0,  -- Makes Lazy's windows transparent
        -- Add these settings to maintain visible borders
        title = "Lazy",
        border_chars = {
            "╭", "─", "╮", "│", "╯", "─", "╰", "│"
        },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    checker = {
      enabled = true, -- automatically check for plugin updates
      notify = false, -- get a notification when new updates are found
    },
})

-- Add this to ensure borders are visible with transparency
vim.api.nvim_set_hl(0, "LazyNormal", { 
    bg = "NONE",
})

-- If borders still aren't visible enough, you can explicitly set the border color
vim.api.nvim_set_hl(0, "LazyBorder", {
    fg = "#9cabca",  -- Adjust this color to match your theme
    bg = "NONE"
})
