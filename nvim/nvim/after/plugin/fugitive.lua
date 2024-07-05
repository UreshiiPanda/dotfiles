-- pull up Fugitive's "git status" buffer
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- git push
vim.keymap.set("n", "<leader>gp", function() vim.cmd.Git('push') end, opts)

-- these are for vDiff (vd) when performing a merge conflict btw 2 options
-- and you can choose R side with "gl" and L side with "gh"
vim.keymap.set("n", "gh", "<cmd>diffget //2<CR>")
vim.keymap.set("n", "gl", "<cmd>diffget //3<CR>")
