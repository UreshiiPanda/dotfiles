
-- this func can be called from inside nvim as:    :lua cme()
-- and any color can be passed in as a string
function cme (color)
	-- default color set below for when no color is passed in
	color = color or "space-vim-dark" 
	vim.cmd.colorscheme(color)

	-- to set bg transparency
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

end


cme()



