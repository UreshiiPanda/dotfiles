-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Telescope plugin
  use {
    	'nvim-telescope/telescope.nvim', tag = '0.1.3',
      	-- or                            , branch = '0.1.x',
    	requires = { {'nvim-lua/plenary.nvim'} },
        -- opts = {hidden=true}

  }
  -- use 'nvim-lua/plenary.nvim'

  -- Colorscheme:  Everforest
  use({
    	"neanias/everforest-nvim",
    	-- Optional; default configuration will be used if setup isn't called.
    	config = function()
      		require("everforest").setup({
	        	background = "soft"
        	})
    end,
  })

  -- ColorScheme:  Rose-Pine
  use({ 
	  'rose-pine/neovim', as = 'rose-pine',
	  config = function() 
  		vim.cmd('colorscheme rose-pine')
	  end
  })

  -- ColorScheme:    nord
  use 'shaunsingh/nord.nvim'

  -- ColorScheme:   GruvBox
  use { "ellisonleao/gruvbox.nvim" }

  -- ColorScheme:   Gotham
  use('whatyouhide/vim-gotham')

  -- ColorScheme:  space-vim-dark
  use('liuchengxu/space-vim-dark')

  -- TreeSitter & TreeSitter PlayGround
  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate' } )
  use('nvim-treesitter/playground')

  -- Harpoon with Plenary as a dependency
  use('nvim-lua/plenary.nvim')
  use('ThePrimeagen/harpoon')

  -- undo tree 
  use ('mbbill/undotree')

  -- Git support
  use ('tpope/vim-fugitive')

  -- lsp-zero
--  use {
--      'VonHeikemen/lsp-zero.nvim',
--      branch = 'v3.x',
--      requires = {
--        --- Uncomment these if you want to manage LSP servers from neovim
--        {'williamboman/mason.nvim'},
--        {'williamboman/mason-lspconfig.nvim'},
--
--        -- LSP Support
--        {'neovim/nvim-lspconfig'},
--
--        -- Autocompletion
--        {'hrsh7th/nvim-cmp'},
--        {'hrsh7th/cmp-nvim-lsp'},
--        {'L3MON4D3/LuaSnip'},
--      }
--  }

  -- LSP
  use {'neovim/nvim-lspconfig',
    requires = {
        {"williamboman/mason.nvim"},
        {"williamboman/mason-lspconfig.nvim"},
        {"hrsh7th/cmp-nvim-lsp"},
        {"hrsh7th/cmp-buffer"},
        {"hrsh7th/cmp-path"},
        {"hrsh7th/cmp-cmdline"},
        {"hrsh7th/nvim-cmp"},
        {"L3MON4D3/LuaSnip"},
        {"saadparwaiz1/cmp_luasnip"},
        {"j-hui/fidget.nvim"},
    }
  }
 -- use "williamboman/mason.nvim"
 -- use "williamboman/mason-lspconfig.nvim"
 -- use "hrsh7th/cmp-nvim-lsp"
 -- use "hrsh7th/cmp-buffer"
 -- use "hrsh7th/cmp-path"
 -- use "hrsh7th/cmp-cmdline"
 -- use "hrsh7th/nvim-cmp"
 -- use "L3MON4D3/LuaSnip"
 -- use "saadparwaiz1/cmp_luasnip"
 -- use "j-hui/fidget.nvim"



  -- for useless animations
  use('eandrju/cellular-automaton.nvim')


  -- trouble for diagnostics
  use ('nvim-tree/nvim-web-devicons')

  use {
       "folke/trouble.nvim",
       requires = { { "nvim-tree/nvim-web-devicons" } },
       opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
       },
  }

  -- zen mode
  use { "folke/zen-mode.nvim",
      opts = {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
      }
  }

end)


