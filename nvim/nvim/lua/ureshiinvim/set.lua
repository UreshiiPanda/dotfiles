-- keep cursor big in insert mode
vim.opt.guicursor = ""

-- lines numbers and relative line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

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

vim.opt.termguicolors = true

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



