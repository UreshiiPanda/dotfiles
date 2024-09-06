-- this func can be called from inside nvim as:    :lua cme()
-- and any color can be passed in as a string
function cme(color)
	-- default color set below for when no color is passed in
	color = color or "space-vim-dark"
	vim.cmd.colorscheme(color)

	-- to set bg transparency
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

	-- Set border colors
	local border_color = "#547998"
	vim.api.nvim_set_hl(0, "FloatBorder", { fg = border_color, bg = "none" })
	vim.api.nvim_set_hl(0, "LspFloatWinBorder", { fg = border_color, bg = "none" })
	vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = border_color, bg = "none" })

	-- Override other highlight groups if needed
	vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
	vim.api.nvim_set_hl(0, "Sidebar", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "TabLine", { bg = "none" })
end

return {

	-- ColorScheme:  space-vim-dark
	{
		"liuchengxu/space-vim-dark",
		-- make sure we load this during startup if it is your main colorscheme
		lazy = false,
		-- make sure to load this before all the other start plugins
		priority = 1000,
		name = "space-vim-dark",
		config = function()
			cme("space-vim-dark")
		end,
	},

	-- ColorScheme:    Tokyo Night
	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				transparent = true,
			})
		end,
	},

	-- ColorScheme:    Rose-Pine
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
			})
		end,
	},

	-- Colorscheme:  Everforest
	{
		"neanias/everforest-nvim",
		config = function() end,
	},

	-- ColorScheme:    Nord
	{
		"shaunsingh/nord.nvim",
		config = function() end,
	},

	-- ColorScheme:   GruvBox
	{
		"ellisonleao/gruvbox.nvim",
		config = function() end,
	},

	-- ColorScheme:   Gotham
	{
		"whatyouhide/vim-gotham",
		config = function() end,
	},
}
