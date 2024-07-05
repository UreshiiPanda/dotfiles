local builtin = require('telescope.builtin')

-- search thru all files
-- tell Telescope to not ignore hiddens, but then tell it to still ignore the .git dir
vim.keymap.set('n', '<leader>f', function() builtin.find_files({no_ignore=true, hidden=true, file_ignore_patterns={".git/", "node_modules/"}}) end, {})

-- search thru only git files
-- Fuzzy search through the output of git ls-files command, respects .gitignore
vim.keymap.set('n', '<leader>gi', builtin.git_files, {})

-- run grep from a file
-- Searches for the string under your cursor or selection in your current working directory
vim.keymap.set('n', '<leader>gg', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

-- Search for a string in your current working directory and 
-- get results live as you type, respects .gitignore. (Requires ripgrep)
vim.keymap.set('n', '<leader>lg', builtin.live_grep, {})

