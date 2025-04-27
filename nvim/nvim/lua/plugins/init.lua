-- for lazy.nvim, we just return a big table of all of our plugins
return {

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-tree/nvim-web-devicons" },
			{
				"folke/todo-comments.nvim",
				event = { "BufReadPre", "BufNewFile" },
				dependencies = { "nvim-lua/plenary.nvim" },
				config = function()
					local todo_comments = require("todo-comments")

					-- set keymaps
					local keymap = vim.keymap

					keymap.set("n", "]t", function()
						todo_comments.jump_next()
					end, { desc = "Todo-Comments: Jump to next todo comment" })

					keymap.set("n", "[t", function()
						todo_comments.jump_prev()
					end, { desc = "Todo-Comments: Jump to previous todo comment" })

					todo_comments.setup()
				end,
			},
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local transform_mod = require("telescope.actions.mt").transform_mod

			local trouble = require("trouble")
			local trouble_telescope = require("trouble.sources.telescope")

			local custom_actions = transform_mod({
				open_trouble_qflist = function(prompt_bufnr)
					trouble.toggle("quickfix")
				end,
			})

			telescope.setup({
				defaults = {
					path_display = { "smart" },
					mappings = {
						i = {
							["<Tab>"] = actions.move_selection_previous,
							["<S-Tab>"] = actions.move_selection_next,
							["<C-i>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
							["<C-b>"] = trouble_telescope.open,
						},
					},
					layout_config = {
						width = 0.85,
						height = 0.85,
					},
					winblend = 0,
				},
			})

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>f", function()
				builtin.find_files({
					no_ignore = true,
					hidden = true,
					file_ignore_patterns = { ".git/", "node_modules/", ".DS_Store" },
				})
			end, { desc = "Telescope: Find files (including hidden)" })

			vim.keymap.set("n", "<leader>gi", builtin.git_files, { desc = "Telescope: Search git files" })
			vim.keymap.set(
				"n",
				"<leader>gg",
				"<cmd>Telescope grep_string<cr>",
				{ desc = "Telescope: Grep string under cursor" }
			)
			vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "Telescope: Live grep" })
			vim.keymap.set("n", "<leader>vh", builtin.help_tags, { desc = "Telescope: Search help tags" })
			vim.keymap.set("n", "<leader>vc", builtin.commands, { desc = "Telescope: Search commands" })
			vim.keymap.set(
				"n",
				"<leader>do",
				"<cmd>TodoTelescope<cr>",
				{ desc = "Telescope Todo-Comments: Find todos in project" }
			)
			vim.keymap.set("n", "<leader>cw", function()
				builtin.grep_string({ search = vim.fn.expand("<cword>") })
			end, { desc = "Telescope: Grep word under cursor" })
			vim.keymap.set("n", "<leader>cW", function()
				builtin.grep_string({ search = vim.fn.expand("<cWORD>") })
			end, { desc = "Telescope: Grep WORD under cursor" })
			vim.keymap.set("n", "<leader>km", "<cmd>Telescope keymaps<CR>", { desc = "Telescope: Search keymaps" })
		end,
	},

	-- Codeium
	{
		"Exafunction/codeium.vim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.keymap.set("i", "<C-a>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, silent = true, desc = "Codeium: Accept suggestion" })
			vim.keymap.set("i", "<C-n>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true, silent = true, desc = "Codeium: Next suggestion" })
			vim.keymap.set("i", "<C-p>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true, silent = true, desc = "Codeium: Previous suggestion" })
			vim.keymap.set("i", "<C-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true, silent = true, desc = "Codeium: Clear suggestions" })
			vim.keymap.set("i", "<C-g>", function()
				return vim.fn["codeium#Complete"]()
			end, { expr = true, silent = true, desc = "Codeium: Trigger completion" })
		end,
	},

	-- Harpoon
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")

			vim.keymap.set("n", "<leader>af", mark.add_file, { desc = "Harpoon: Add file to marks" })
			vim.keymap.set("n", "<leader>qm", ui.toggle_quick_menu, { desc = "Harpoon: Toggle quick menu" })

			vim.keymap.set("n", "<leader>1", function()
				ui.nav_file(1)
			end, { desc = "Harpoon: Navigate to file 1" })
			vim.keymap.set("n", "<leader>2", function()
				ui.nav_file(2)
			end, { desc = "Harpoon: Navigate to file 2" })
			vim.keymap.set("n", "<leader>3", function()
				ui.nav_file(3)
			end, { desc = "Harpoon: Navigate to file 3" })
			vim.keymap.set("n", "<leader>4", function()
				ui.nav_file(4)
			end, { desc = "Harpoon: Navigate to file 4" })
		end,
	},

	-- UndoTree
	{
		"mbbill/undotree",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "UndoTree: Toggle undo tree" })
			vim.keymap.set("n", "<leader>uf", "<cmd>UndotreeFocus<CR>", { desc = "UndoTree: Focus undo tree" })

			vim.g.undotree_WindowLayout = 2
			vim.g.undotree_SetFocusWhenToggle = 1
		end,
	},

	-- Git Fugitive
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Fugitive: Git status" })
			vim.keymap.set("n", "<leader>gp", function()
				vim.cmd.Git("push")
			end, { desc = "Fugitive: Git push" })
			vim.keymap.set("n", "gh", "<cmd>diffget //2<CR>", { desc = "Fugitive: Get diff from left" })
			vim.keymap.set("n", "gl", "<cmd>diffget //3<CR>", { desc = "Fugitive: Get diff from right" })
		end,
	},

	-- TreeSitter
	{
		"nvim-treesitter/nvim-treesitter",
		-- ensure that all lang parsers are updated everytime we startup TreeSitter
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all" (these 10 listed parsers should always be installed)
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"markdown",
					"markdown_inline",
					"python",
					"javascript",
					"sql",
					"yaml",
					"json",
					"gitcommit",
					"gitignore",
					"go",
					"bash",
				},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,

				highlight = {
					enable = true,
					-- list of language that will be disabled
					disable = {},

					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},

	-- LSP
	{
		-- a plugin for LSP functionality
		"neovim/nvim-lspconfig",
		-- load the LSP whenever we open a new buffer for a pre-existing file or for a new file
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			-- Mason is a package manager for all things LSP
			{ "williamboman/mason.nvim", event = { "BufReadPre", "BufNewFile" } },
			{ "williamboman/mason-lspconfig.nvim", event = { "BufReadPre", "BufNewFile" } },
			{ "WhoIsSethDaniel/mason-tool-installer.nvim", event = { "BufReadPre", "BufNewFile" } },
			-- completion plugin not just for the curr file but also for all of Neovim
			{ "hrsh7th/cmp-nvim-lsp", event = { "BufReadPre", "BufNewFile" } },
			{ "hrsh7th/cmp-buffer", event = { "BufReadPre", "BufNewFile" } },
			{ "hrsh7th/cmp-path", event = { "BufReadPre", "BufNewFile" } },
			{ "hrsh7th/cmp-cmdline", event = { "BufReadPre", "BufNewFile" } },
			{
				"hrsh7th/nvim-cmp",
				event = "InsertEnter",
			},
			-- snippet engine for defining/saving code snippets on the fly in a shortcut and having them show up in completion suggestions
			{
				"L3MON4D3/LuaSnip",
				-- follow latest release of LuaSnip
				version = "v2.*",
				build = "make install_jsregexp",
			},
			{ "saadparwaiz1/cmp_luasnip", event = { "BufReadPre", "BufNewFile" } },
			-- this is a useful snippet library
			{ "rafamadriz/friendly-snippets", event = { "BufReadPre", "BufNewFile" } },
			-- this is for nice pictograms
			{ "onsails/lspkind.nvim", event = { "BufReadPre", "BufNewFile" } },
			-- this is for showing Neovim and LSP notifications
			{ "j-hui/fidget.nvim", event = { "BufReadPre", "BufNewFile" } },
		},
		config = function()
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
			})

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = "rounded",
			})

			-- LspAttach will perform these only after a given LSP attaches to the buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
				callback = function(event)
					local opts = { buffer = event.buf }

					vim.keymap.set("n", "gd", function()
						vim.lsp.buf.definition()
					end, { buffer = event.buf, desc = "LSP: Go to definition" })
					vim.keymap.set("n", "K", function()
						vim.lsp.buf.hover()
					end, { buffer = event.buf, desc = "LSP: Show hover documentation" })
					vim.keymap.set("n", "<leader>vw", function()
						vim.lsp.buf.workspace_symbol()
					end, { buffer = event.buf, desc = "LSP: Search workspace symbols" })
					vim.keymap.set("n", "<leader>dl", function()
						vim.diagnostic.open_float()
					end, { buffer = event.buf, desc = "LSP: Show diagnostics in float" })
					vim.keymap.set("n", "[d", function()
						vim.diagnostic.goto_next()
					end, { buffer = event.buf, desc = "LSP: Go to next diagnostic" })
					vim.keymap.set("n", "]d", function()
						vim.diagnostic.goto_prev()
					end, { buffer = event.buf, desc = "LSP: Go to previous diagnostic" })
					vim.keymap.set("n", "<leader>ca", function()
						vim.lsp.buf.code_action()
					end, { buffer = event.buf, desc = "LSP: Show code actions" })
					vim.keymap.set("n", "<leader>vr", function()
						vim.lsp.buf.references()
					end, { buffer = event.buf, desc = "LSP: Find references" })
					vim.keymap.set("n", "<leader>vn", function()
						vim.lsp.buf.rename()
					end, { buffer = event.buf, desc = "LSP: Rename symbol" })
					vim.keymap.set("n", "<leader>ms", function()
						vim.lsp.buf.signature_help()
					end, { buffer = event.buf, desc = "LSP: Show signature help" })
				end,
			})

			-- this enables auto-completion for each lang server (see below)
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- incorporate Fidget for LSP progress msgs
			require("fidget").setup({})
			-- incorporate Mason for LSP management
			-- see lang servers by typing in:    :Mason
			require("mason").setup({
				ui = {
					border = "rounded",
				},
			})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"vimls",
					"lua_ls",
					"bashls",
					"cssls",
					"css_variables",
					"cssmodules_ls",
					"tailwindcss",
					"diagnosticls",
					"dockerls",
					"gopls",
					"htmx",
					"jsonls",
					"markdown_oxide",
					"pyright",
					"sqlls",
					"yamlls",
				},

				require("mason-tool-installer").setup({
					ensure_installed = {
						"prettier",
						"stylua",
						"isort",
						"black",
						"shfmt",
						"goimports",
						"gofumpt",
						"djlint",
						"sqlfmt",
						"sqlfluff",
						"markdownlint",
						"jsonlint",
						"yamllint",
						"gitlint",
						"pylint",
						"eslint_d",
					},
				}),
				automatic_installation = true,
				handlers = {
					-- set up all of our LSP servers
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = lsp_capabilities,
						})
					end,

					-- Lua needs a special setup
					lua_ls = function()
						require("lspconfig").lua_ls.setup({
							capabilities = lsp_capabilities,
							settings = {
								Lua = {
									runtime = {
										version = "LuaJIT",
									},
									-- we have to set this so that the incoming lang server can recog the "vim" global var
									diagnostics = {
										globals = { "vim" },
									},
									workspace = {
										-- here we make the lang server aware of any runtime files
										library = {
											vim.env.VIMRUNTIME,
											vim.fn.expand("$VIMRUNTIME/lua"),
											vim.fn.stdpath("config") .. "/lua",
										},
									},
								},
							},
						})
					end,
				},
			})

			-- incorporate cmp for code completion
			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			-- this is the function that loads any extra snippets via luasnip
			-- eg: extra VS-Code style snippets from rafamadriz/friendly-snippets
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({

				completion = {
					completeopt = "menu,menuone,preview,noselect",
				},

				-- tell cmp which sources to get completion info from
				-- the order of these is the order that they will appear in the pop-up menu
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "luasnip", keyword_length = 2 },
					{ name = "buffer", keyword_length = 3 },
				},

				-- these are for the dropdown menu that appears for code completion suggestions
				-- the cmp.mapping.complete shows the entire list of possibilities
				mapping = cmp.mapping.preset.insert({
					["<D-k>"] = cmp.mapping.select_prev_item(cmp_select),
					["<D-j>"] = cmp.mapping.select_next_item(cmp_select),
					["<D-u>"] = cmp.mapping.scroll_docs(-4),
					["<D-d>"] = cmp.mapping.scroll_docs(4),
					["<D-;>"] = cmp.mapping.confirm({ select = true }),
					["<D-f>"] = cmp.mapping.complete(),
				}),

				-- configure how nvim-cmp interacts with snippet engine
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},

				-- configure LspKind for vs-code like pictograms in completion menu
				formatting = {
					format = require("lspkind").cmp_format({
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},

				-- add window borders to cmp and cmp previews
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			})
		end,
	},

	-- for useless animations
	-- Cellular Automaton
	{
		"eandrju/cellular-automaton.nvim",
		config = function()
			vim.keymap.set(
				"n",
				"<leader>mr",
				"<cmd>CellularAutomaton make_it_rain<CR>",
				{ desc = "Cellular-Automaton: Make it rain effect" }
			)
			vim.keymap.set(
				"n",
				"<leader>gl",
				"<cmd>CellularAutomaton game_of_life<CR>",
				{ desc = "Cellular-Automaton: Game of Life" }
			)
		end,
	},

	-- Zen mode
	{
		"folke/zen-mode.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.keymap.set("n", "<leader>zz", function()
				require("zen-mode").setup({
					window = {
						width = 1,
						height = 1,
						options = {
							signcolumn = "no",
							number = false,
							relativenumber = false,
							cursorline = false,
							cursorcolumn = false,
						},
					},
				})
				require("zen-mode").toggle()
				vim.wo.wrap = false
				vim.wo.number = true
				vim.wo.rnu = true
				cme("nord")
			end, { desc = "Zen-Mode: Toggle minimal zen mode" })

			vim.keymap.set("n", "<leader>zs", function()
				require("zen-mode").setup({
					window = {
						width = 150,
						options = {},
					},
				})
				require("zen-mode").toggle()
				vim.wo.wrap = false
				vim.wo.number = false
				vim.wo.rnu = false
				vim.opt.colorcolumn = "0"
				cme("gotham")
			end, { desc = "Zen-Mode: Toggle wide zen mode" })
		end,
	},

	-- Conform (formatting)
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					javascript = { "prettier" },
					typescript = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					lua = { "stylua" },
					python = { "isort", "black" },
					bash = { "shfmt" },
					go = { "goimports", "gofumpt" },
					django = { "djlint" },
					sql = { "sqlfmt" },
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>mp", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "Conform: Format file or selection" })
		end,
	},

	-- Nvim-lint
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				python = { "pylint" },
				django = { "djlint" },
				json = { "jsonlint" },
				yaml = { "yamllint" },
				markdown = { "markdownlint" },
				sql = { "sqlfluff" },
				git = { "gitlint" },
			}

			vim.keymap.set("n", "<leader>li", function()
				lint.try_lint()
			end, { desc = "Nvim-Lint: Trigger linting for current file" })
		end,
	},

	{
		-- provides tons of options for improving Vim's built-in popup UI
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {},
	},

	-- AI Chat
	{
		"robitx/gp.nvim",
		config = function()
			local conf = {
				providers = {
					anthropic = {
						endpoint = "https://api.anthropic.com/v1/messages",
						secret = os.getenv("ANTHROPIC_API_KEY"),
					},
					ollama = {
						endpoint = "http://localhost:11434/v1/chat/completions",
						disable = true,
						secret = "put_secret_here",
					},
				},
				-- if you want to set a custom agent, set diable to false
				agents = {
					{
						provider = "anthropic",
						name = "ChatClaude-3-5-Sonnet",
						disable = true,
						chat = true,
						command = false,
						-- string with model name or table with model name and parameters
						model = { model = "claude-3-5-sonnet-20240620", temperature = 0.8, top_p = 1 },
						-- system prompt (use this to specify the persona/role of the AI)
						system_prompt = require("gp.defaults").chat_system_prompt,
						--system_prompt = "You are a general AI assistant.",
					},
					{
						provider = "ollama",
						name = "ChatOllamaLlama3.1-8B",
						disable = true,
						chat = true,
						command = false,
						-- string with model name or table with model name and parameters
						model = {
							model = "llama3.1",
							temperature = 0.6,
							top_p = 1,
							min_p = 0.05,
						},
						-- system prompt (use this to specify the persona/role of the AI)
						system_prompt = "You are a general AI assistant.",
					},
				},
				-- chat_user_prefix = "💬:",

				-- chat assistant prompt prefix (static string or a table {static, template})
				-- first string has to be static, second string can contain template {{agent}}
				-- just a static string is legacy and the [{{agent}}] element is added automatically
				-- if you really want just a static string, make it a table with one element { "🤖:" }

				-- chat_assistant_prefix = { "🤖:", "[{{agent}}]" },

				-- local shortcuts bound to the chat buffer
				-- (be careful to choose something which will work across specified modes)
				chat_shortcut_respond = { modes = { "n", "v", "x" }, shortcut = "<leader>cbr" },
				chat_shortcut_delete = { modes = { "n", "v", "x" }, shortcut = "<leader>cbd" },
				chat_shortcut_stop = { modes = { "n", "v", "x" }, shortcut = "<leader>cbs" },
				chat_shortcut_new = { modes = { "n", "v", "x" }, shortcut = "<leader>cbn" },

				-- how to display GpChatToggle or GpContext: popup / split / vsplit / tabnew
				toggle_target = "vsplit",
			}
			require("gp").setup(conf)

			-- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
			local function keymapOptions(desc)
				return {
					noremap = true,
					silent = true,
					nowait = true,
					desc = "GPT prompt " .. desc,
				}
			end

			-- chat commands
			vim.keymap.set("n", "<leader>aiv", "<cmd>GpChatToggle vsplit<cr>", { desc = "GP: Toggle chat in vsplit" })
			vim.keymap.set("n", "<leader>aip", "<cmd>GpChatToggle popup<cr>", { desc = "GP: Toggle chat in popup" })
			vim.keymap.set("n", "<leader>ait", "<cmd>GpChatToggle tabnew<cr>", { desc = "GP: Toggle chat in new tab" })
			vim.keymap.set("v", "<leader>aiw", ":<C-u>'<,'>GpChatPaste<cr>", { desc = "GP: Paste selection into chat" })
			vim.keymap.set(
				"v",
				"<leader>aiv",
				":<C-u>'<,'>GpChatToggle vsplit<cr>",
				{ desc = "GP: Toggle chat with selection in vsplit" }
			)
			vim.keymap.set(
				"v",
				"<leader>aip",
				":<C-u>'<,'>GpChatToggle popup<cr>",
				{ desc = "GP: Toggle chat with selection in popup" }
			)
			vim.keymap.set(
				"v",
				"<leader>ait",
				":<C-u>'<,'>GpChatToggle tabnew<cr>",
				{ desc = "GP: Toggle chat with selection in new tab" }
			)
			vim.keymap.set("n", "<C-g>j", "<cmd>GpContext<cr>", { desc = "GP: Toggle context" })
			vim.keymap.set("v", "<C-g>j", ":<C-u>'<,'>GpContext<cr>", { desc = "GP: Toggle context for selection" })
		end,
	},
	{
		-- note-taking plugin with markdown-like syntax
		"nvim-neorg/neorg",
		lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
		version = "*", -- Pin Neorg to the latest stable release
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {},
					["core.dirman"] = {
						config = {
							workspaces = {
								notes = "~/notes",
							},
							default_workspace = "notes",
						},
					},
				},
			})

			-- Set keymap for ':Neorg index'
			vim.keymap.set("n", "<Leader>no", ":Neorg index<CR>", { noremap = true, silent = true })

			vim.wo.foldlevel = 99
			vim.wo.conceallevel = 2
		end,
	},
	-- Vim Table Mode
	-- make simple tables in nvim
	{
		"dhruvasagar/vim-table-mode",
		config = function()
			-- disable all native bindings, then set your own
			vim.g.table_mode_disable_mappings = 1
			vim.g.table_mode_disable_tableize_mappings = 1

			-- Explicitly unmap <leader>tt to avoid conflicts with Trouble
			-- vim.keymap.del("n", "<leader>tt")
			-- vim.keymap.del("n", "<leader>T")

			vim.keymap.set(
				"n",
				"<Leader>tmt",
				":TableModeToggle<CR>",
				{ noremap = true, silent = true, desc = "Table-Mode: Toggle table mode" }
			)
			vim.keymap.set(
				"n",
				"<Leader>tmc",
				":Tableize<CR>",
				{ noremap = true, silent = true, desc = "Table-Mode: Convert to table" }
			)
		end,
	},

	-- Trouble
	{
		"folke/trouble.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
		},
		opts = {
			focus = true,
		},
		cmd = "Trouble",
		keys = {
			{
				"<leader>tt",
				"<cmd>Trouble diagnostics toggle <cr>",
				desc = "Trouble: Toggle Trouble diagnostics",
			},
			{
				"<leader>T",
				"<cmd>Trouble diagnostics toggle <cr>",
				desc = "Trouble: Toggle Trouble diagnostics",
			},

			{
				"<leader>qf",
				"<cmd>Trouble qflist toggle <cr>",
				desc = "Trouble: Toggle quickfix list",
			},
			{
				"<leader>ts",
				"<cmd>Trouble symbols toggle win.position=bottom <cr>",
				desc = "Trouble: Toggle symbols",
			},
			{
				"<leader>td",
				"<cmd>Trouble lsp toggle win.position=bottom <cr>",
				desc = "Trouble: Toggle LSP",
			},
			{
				"<leader>tl",
				"<cmd>Trouble loclist toggle <cr>",
				desc = "Trouble: Toggle location list",
			},
			{
				"<leader>tdo",
				"<cmd>Trouble todo toggle <cr>",
				desc = "Trouble: Toggle todo list",
			},
		},
	},
	-- snacks
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			-- Create ~/image_notes directory if it doesn't exist
			local image_dir = vim.fn.expand("~/image_notes")
			if vim.fn.isdirectory(image_dir) == 0 then
				vim.fn.mkdir(image_dir, "p")
			end

			-- Configure the snacks.image module
			require("snacks").setup({
				-- Only enable the image plugin
				image = {
					enabled = true,
					formats = {
						"png",
						"jpg",
						"jpeg",
						"gif",
						"bmp",
						"webp",
						"tiff",
						"heic",
						"avif",
						"mp4",
						"mov",
						"avi",
						"mkv",
						"webm",
						"pdf",
					},
					-- Try displaying images even when terminal detection is inconsistent
					force = true,
					doc = {
						-- enable image viewer for documents
						enabled = true,
						-- render images inline in the buffer on supported terminals
						inline = true,
						-- render the image in a floating window if inline is disabled
						float = true,
						max_width = 80,
						max_height = 40,
						-- Don't conceal the image text
						conceal = false,
					},
					-- Include all standard image directories plus ~/image_notes
					img_dirs = {
						"img",
						"images",
						"assets",
						"static",
						"public",
						"media",
						"attachments",
						vim.fn.expand("~/image_notes"),
					},
					-- Custom image resolver that checks multiple locations
					resolve = function(file, src)
						-- If src starts with '~', expand it
						if string.sub(src, 1, 1) == "~" then
							return vim.fn.expand(src)
						end

						-- Check if it's an absolute path
						if vim.fn.fnamemodify(src, ":p") == src then
							return src
						end

						-- Try in image_notes directory with basename
						local in_image_notes = vim.fn.expand("~/image_notes/") .. vim.fn.fnamemodify(src, ":t")
						if vim.fn.filereadable(in_image_notes) == 1 then
							return in_image_notes
						end

						-- Try relative to the current file
						local relative_to_file = vim.fn.fnamemodify(file, ":p:h") .. "/" .. src
						if vim.fn.filereadable(relative_to_file) == 1 then
							return relative_to_file
						end

						-- Try with standard directories
						for _, dir in ipairs({ "img", "images", "assets", "static" }) do
							local path = vim.fn.fnamemodify(file, ":p:h")
								.. "/"
								.. dir
								.. "/"
								.. vim.fn.fnamemodify(src, ":t")
							if vim.fn.filereadable(path) == 1 then
								return path
							end
						end

						-- Default to just returning the source
						return src
					end,
					-- Debug options to help troubleshoot
					debug = {
						request = true,
						convert = true,
						placement = true,
					},
					-- window options for image display
					wo = {
						wrap = false,
						number = false,
						relativenumber = false,
						cursorcolumn = false,
						signcolumn = "no",
						foldcolumn = "0",
						list = false,
						spell = false,
						statuscolumn = "",
					},
				},

				-- Explicitly disable all other snacks plugins
				animate = { enabled = false },
				bigfile = { enabled = false },
				bufdelete = { enabled = false },
				dashboard = { enabled = false },
				debug = { enabled = false },
				dim = { enabled = false },
				explorer = { enabled = false },
				git = { enabled = false },
				gitbrowse = { enabled = false },
				indent = { enabled = false },
				input = { enabled = false },
				layout = { enabled = false },
				lazygit = { enabled = false },
				notifier = { enabled = false },
				notify = { enabled = false },
				picker = { enabled = false },
				profiler = { enabled = false },
				quickfile = { enabled = false },
				rename = { enabled = false },
				scope = { enabled = false },
				scratch = { enabled = false },
				scroll = { enabled = false },
				statuscolumn = { enabled = false },
				terminal = { enabled = false },
				toggle = { enabled = false },
				util = { enabled = false },
				win = { enabled = false },
				words = { enabled = false },
				zen = { enabled = false },
			})
		end,
		keys = {
			{
				"<leader>ih",
				function()
					-- Force the image to display by explicitly calling the hover function
					local image = require("snacks").image
					if image then
						image.hover()
					end
				end,
				desc = "Show image at cursor",
			},
			{
				"<leader>ic",
				function()
					local image = require("snacks").image
					if image then
						image.clear()
					end
				end,
				desc = "Clear images",
			},
			{
				"<leader>id",
				function()
					-- Debug command to print information about the current environment
					local snacks = require("snacks")
					if snacks and snacks.image then
						vim.notify("Snacks image environment info:")
						vim.notify("Terminal: " .. vim.inspect(snacks.image.terminal.env))
						vim.notify("Current file: " .. vim.fn.expand("%:p"))
						-- Force reload images in the current buffer
						if snacks.image.doc then
							snacks.image.doc.update()
						end
					end
				end,
				desc = "Debug image display",
			},
		},
	},
	-- Image paste functionality with img-clip.nvim
	{
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		opts = {
			-- Default configuration for all filetypes
			default = {
				-- Save images to ~/image_notes directory
				dir_path = vim.fn.expand("~/image_notes"),
				-- Use relative path from current file but check multiple locations
				relative_to_current_file = false,
				-- Use absolute path to better support all environments
				use_absolute_path = true,
				-- Format for the image filename (timestamp-based by default)
				file_name = function()
					return "image_" .. os.date("%Y%m%d%H%M%S")
				end,
				-- File extension
				extension = "png",
				-- Template for insertion (supports $FILE_PATH, $CURSOR placeholders)
				template = "![$CURSOR]($FILE_PATH)",
				-- Automatically enter insert mode after pasting
				insert_mode_after_paste = true,
				-- Don't prompt for filename
				prompt_for_file_name = false,
				-- Additional image processing (e.g., compression)
				process_cmd = "", -- For image processing, e.g.: "convert - -resize 50% -"
				-- Copy images when referenced from other paths
				copy_images = true,
				-- Download images from URLs
				download_images = true,
			},

			-- Filetype-specific options
			filetypes = {
				markdown = {
					template = "![$CURSOR]($FILE_PATH)",
					url_encode_path = false,
				},
				html = {
					template = '<img src="$FILE_PATH" alt="$CURSOR">',
				},
				-- Neorg specific configuration
				norg = {
					-- Neorg uses a specific syntax for images
					template = "{image: $FILE_PATH}\n$CURSOR",
					-- Don't URL encode paths for Neorg
					url_encode_path = false,
				},
			},

			-- Enable drag-and-drop support
			drag_and_drop = {
				enabled = true,
				insert_mode = false, -- Whether to enable in insert mode
			},
		},
		keys = {
			-- Suggested keymap
			{ "<leader>ip", "<cmd>PasteImage<cr>", desc = "Paste image from clipboard" },
		},
		-- Make sure the image_notes directory exists
		config = function(_, opts)
			-- Create the image_notes directory if it doesn't exist
			local image_dir = vim.fn.expand("~/image_notes")
			if vim.fn.isdirectory(image_dir) == 0 then
				vim.fn.mkdir(image_dir, "p")
			end

			require("img-clip").setup(opts)
		end,
	},
}
