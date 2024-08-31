
-- for lazy.nvim, we just return a big table of all of our plugins
return {

  -- Telescope
  {
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require('telescope.builtin')

        -- search thru all files
        -- tell Telescope to not ignore hiddens, but then tell it to still ignore the .git dir
        vim.keymap.set('n', '<leader>f', function() builtin.find_files({no_ignore=true, hidden=true, file_ignore_patterns={".git/", "node_modules/", ".DS_Store"}}) end, {})

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

        -- search through vim help keywords
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

        -- search through vim commands
        vim.keymap.set('n', '<leader>vc', builtin.commands, {})

        -- grep search for the smaller word under the cursor
        vim.keymap.set('n', '<leader>cw', function()
            builtin.grep_string({ search = vim.fn.expand("<cword>") })
        end)

        -- grep search for the entire word/phrase under the cursor
        vim.keymap.set('n', '<leader>cW', function()
            builtin.grep_string({ search = vim.fn.expand("<cWORD>") })
        end)

    end,


  },


  -- Codeium
  {
      'Exafunction/codeium.vim',
      config = function ()
        -- Change '<C-g>' here to any keycode you like.
        vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
        vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
        vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
        vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
      end
  },


  -- TreeSitter
  {
        'nvim-treesitter/nvim-treesitter', 
        build = ':TSUpdate',
        config = function()
              require'nvim-treesitter.configs'.setup {
              -- A list of parser names, or "all" (these 10 listed parsers should always be installed)
              ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "javascript"},

              -- Install parsers synchronously (only applied to `ensure_installed`)
              sync_install = false,

              -- Automatically install missing parsers when entering buffer
              -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
              auto_install = true,

              highlight = {
                enable = true,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
              },
            }
        end,

  },

  -- Harpoon
  {
      'ThePrimeagen/harpoon',
      dependencies = {
        {'nvim-lua/plenary.nvim'}
      },
      config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")


            vim.keymap.set("n", "<leader>a", mark.add_file)
            vim.keymap.set("n", "<leader>m", ui.toggle_quick_menu)


            vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end)
        end,

  },


  -- undo tree 
  {
      'mbbill/undotree',
      config = function()
            vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>")
            vim.keymap.set("n", "<leader>uf", "<cmd>UndotreeFocus<CR>")

            vim.g.undotree_WindowLayout = 2
            vim.g.undotree_SetFocusWhenToggle = 1
        end,


  },

  -- Git Fugitive
  {
      'tpope/vim-fugitive',
      config = function()
            -- pull up Fugitive's "git status" buffer
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git)                   

            -- git push
            vim.keymap.set("n", "<leader>gp", function() vim.cmd.Git('push') end, opts)

            -- these are for vDiff (vd) when performing a merge conflict btw 2 options
            -- and you can choose R side with "gl" and L side with "gh"
            vim.keymap.set("n", "gh", "<cmd>diffget //2<CR>")
            vim.keymap.set("n", "gl", "<cmd>diffget //3<CR>")
        end,
  },

  -- LSP
  {
        'neovim/nvim-lspconfig',
        dependencies = {
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
        },
        config = function()
            
            vim.api.nvim_create_autocmd('LspAttach', {
              group = vim.api.nvim_create_augroup('user_lsp_attach', {clear = true}),
              callback = function(event)
                local opts = {buffer = event.buf}

                -- goto definition
                vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
                -- show quick info on item under hover
                vim.keymap.set('n', '<leader>I', function() vim.lsp.buf.hover() end, opts)
                -- this is a way that the LSP can detect symbols across your entire curr workspace, 
                -- instead of just curr file. But some LSPs can't do this or need some sort of setup
                -- file to do this  (eg: JS has a package.json which allows the LSP to detect the curr
                -- "workspace" and all files/symbols in it
                vim.keymap.set('n', '<leader>vw', function() vim.lsp.buf.workspace_symbol() end, opts)
                -- open a quick diagnostic info on error/warning under the cursor
                vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
                -- goto next diagnostic in file
                vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
                -- goto prev diagnostic in file
                vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
                -- see which code-actions the LSP server offers for the item under the cursor
                -- some LSPs do not provide any code actions
                vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
                -- show all refs to the item under the cursor in this file
                vim.keymap.set('n', '<leader>vr', function() vim.lsp.buf.references() end, opts)
                -- rename the var under the cursor everywhere it occurs in the file
                vim.keymap.set('n', '<leader>vn', function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
              end,
            })

            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()



            -- incorporate Mason for easy LS installing
            -- see lang servers by typing in:    :Mason
            require('mason').setup({})
            require('mason-lspconfig').setup({
              ensure_installed = {'tsserver', 'rust_analyzer'},
              handlers = {
                function(server_name)
                  require('lspconfig')[server_name].setup({
                    capabilities = lsp_capabilities,
                  })
                end,
                lua_ls = function()
                  require('lspconfig').lua_ls.setup({
                    capabilities = lsp_capabilities,
                    settings = {
                      Lua = {
                        runtime = {
                          version = 'LuaJIT'
                        },
                        diagnostics = {
                          globals = {'vim'},
                        },
                        workspace = {
                          library = {
                            vim.env.VIMRUNTIME,
                          }
                        }
                      }
                    }
                  })
                end,
              }
            })


            -- incorporate cmp for code completion
            local cmp = require('cmp')
            local cmp_select = {behavior = cmp.SelectBehavior.Select}


            -- this is the function that loads the extra snippets to luasnip
            -- from rafamadriz/friendly-snippets
            require('luasnip.loaders.from_vscode').lazy_load()

            cmp.setup({
              sources = {
                {name = 'path'},
                {name = 'nvim_lsp'},
                {name = 'luasnip', keyword_length = 2},
                {name = 'buffer', keyword_length = 3},
              },
              -- these are for the dropdown menu that appears for code completion suggestions
              -- the cmp.mapping.complete shows the entire list of possibilities
              mapping = cmp.mapping.preset.insert({
                ['<D-l>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<D-j>'] = cmp.mapping.select_next_item(cmp_select),
                ['<D-i>'] = cmp.mapping.confirm({ select = true }),
                ['<D-f>'] = cmp.mapping.complete(),
              }),
              snippet = {
                expand = function(args)
                  require('luasnip').lsp_expand(args.body)
                end,
              },
            })
        end,

  },

  -- for useless animations
  {
      'eandrju/cellular-automaton.nvim',
      config = function() 
          vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")
          vim.keymap.set("n", "<leader>gl", "<cmd>CellularAutomaton game_of_life<CR>")
      end,
  },

  -- Trouble for diagnostics
  {
    "folke/trouble.nvim",
    dependencies = {
        {"nvim-tree/nvim-web-devicons"},
    },
    opts = {}, 
    cmd = "Trouble",
    keys = {
      {
        "<leader>tt",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>qf",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
    },
  },

  -- Zen mode
  { 
      "folke/zen-mode.nvim",
      config = function()
            vim.keymap.set("n", "<leader>zz", function()
            require("zen-mode").setup {
                window = {
                    width = 90,
                    options = { }
                },
            }
            require("zen-mode").toggle()
            vim.wo.wrap = false
            vim.wo.number = true
            vim.wo.rnu = true
            cme("nord")
        end)


        vim.keymap.set("n", "<leader>zs", function()
            require("zen-mode").setup {
                window = {
                    width = 80,
                    options = { }
                },
            }
            require("zen-mode").toggle()
            vim.wo.wrap = false
            vim.wo.number = false
            vim.wo.rnu = false
            vim.opt.colorcolumn = "0"
            cme("gotham")
        end)

    end,
  },

  {
      "David-Kunz/gen.nvim",
      opts = {
          model = "llama3.1", -- The default model to use.
          quit_map = "q", -- set keymap for close the response window
          retry_map = "<c-r>", -- set keymap to re-send the current prompt
          accept_map = "<c-cr>", -- set keymap to replace the previous selection with the last result
          host = "localhost", -- The host running the Ollama service.
          port = "11434", -- The port on which the Ollama service is listening.
          display_mode = "float", -- The display mode. Can be "float" or "split" or "horizontal-split".
          show_prompt = false, -- Shows the prompt submitted to Ollama.
          show_model = true, -- Displays which model you are using at the beginning of your chat session.
          no_auto_close = false, -- Never closes the window automatically.
          hidden = false, -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
          init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
          -- Function to initialize Ollama
          command = function(options)
              local body = {model = options.model, stream = true}
              return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
          end,
          -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
          -- This can also be a command string.
          -- The executed command must return a JSON object with { response, context }
          -- (context property is optional).
          -- list_models = '<omitted lua function>', -- Retrieves a list of model names
          debug = false -- Prints errors and the command which is run.
      }
  },

}

