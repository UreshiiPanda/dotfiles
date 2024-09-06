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
					end, { desc = "Next todo comment" })

					keymap.set("n", "[t", function()
						todo_comments.jump_prev()
					end, { desc = "Previous todo comment" })

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

			-- or create your custom action
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
							["<C-k>"] = actions.move_selection_previous, -- move to prev result
							["<C-j>"] = actions.move_selection_next, -- move to next result
							["<C-i>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
							["<C-t>"] = trouble_telescope.open,
						},
					},
				},
			})

			local builtin = require("telescope.builtin")
			-- search thru all files
			-- tell Telescope to not ignore hiddens, but then tell it to still ignore the .git dir
			vim.keymap.set("n", "<leader>f", function()
				builtin.find_files({
					no_ignore = true,
					hidden = true,
					file_ignore_patterns = { ".git/", "node_modules/", ".DS_Store" },
				})
			end, {})
			-- search thru only git files
			-- Fuzzy search through the output of git ls-files command, respects .gitignore
			vim.keymap.set("n", "<leader>gi", builtin.git_files, {})
			-- run grep from a file
			-- Searches for the string under your cursor or selection in your current working directory
			vim.keymap.set("n", "<leader>gg", "<cmd>Telescope grep_string<cr>", {})
			-- Search for a string in your current working directory and
			-- get results live as you type, respects .gitignore. (Requires ripgrep)
			vim.keymap.set("n", "<leader>lg", builtin.live_grep, {})
			-- search through vim help keywords
			vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
			-- search through vim commands
			vim.keymap.set("n", "<leader>vc", builtin.commands, {})
			-- search through all TODO comments
			vim.keymap.set("n", "<leader>do", "<cmd>TodoTelescope<cr>", { desc = "Find Todos in Project" })
			-- grep search for the smaller word under the cursor
			vim.keymap.set("n", "<leader>cw", function()
				builtin.grep_string({ search = vim.fn.expand("<cword>") })
			end)
			-- grep search for the entire word/phrase under the cursor
			vim.keymap.set("n", "<leader>cW", function()
				builtin.grep_string({ search = vim.fn.expand("<cWORD>") })
			end)
		end,
	},

	-- Codeium
	{
		"Exafunction/codeium.vim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.keymap.set("i", "<C-g>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<C-;>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<C-,>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<C-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true, silent = true })
			-- this one tells Codeium to come up with a completion suggestion
			vim.keymap.set("i", "<C-s>", function()
				return vim.fn["codeium#Complete"]()
			end, { expr = true, silent = true })
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
					"html",
					"gitcommit",
					"gitignore",
					"go",
					"bash",
					"css",
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

	-- Harpoon
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")

			vim.keymap.set("n", "<leader>af", mark.add_file)
			vim.keymap.set("n", "<leader>qm", ui.toggle_quick_menu)

			vim.keymap.set("n", "<leader>1", function()
				ui.nav_file(1)
			end)
			vim.keymap.set("n", "<leader>2", function()
				ui.nav_file(2)
			end)
			vim.keymap.set("n", "<leader>3", function()
				ui.nav_file(3)
			end)
			vim.keymap.set("n", "<leader>4", function()
				ui.nav_file(4)
			end)
		end,
	},

	-- UndoTree
	{
		"mbbill/undotree",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>")
			vim.keymap.set("n", "<leader>uf", "<cmd>UndotreeFocus<CR>")

			vim.g.undotree_WindowLayout = 2
			vim.g.undotree_SetFocusWhenToggle = 1
		end,
	},

	-- Git Fugitive
	{
		"tpope/vim-fugitive",
		config = function()
			-- pull up Fugitive's "git status" buffer
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

			-- git push
			vim.keymap.set("n", "<leader>gp", function()
				vim.cmd.Git("push")
			end, opts)

			-- these are for vDiff (vd) when performing a merge conflict btw 2 options
			-- and you can choose R side with "gl" and L side with "gh"
			vim.keymap.set("n", "gh", "<cmd>diffget //2<CR>")
			vim.keymap.set("n", "gl", "<cmd>diffget //3<CR>")
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

					-- goto definition
					vim.keymap.set("n", "gd", function()
						vim.lsp.buf.definition()
					end, opts)
					-- look at quick info from Docs on item under hover
					vim.keymap.set("n", "K", function()
						vim.lsp.buf.hover()
					end, opts)
					-- this is a way that the LSP can detect symbols across your entire curr workspace,
					-- instead of just curr file. But some LSPs can't do this or need some sort of setup
					-- file to do this  (eg: JS has a package.json which allows the LSP to detect the curr
					-- "workspace" and all files/symbols in it
					vim.keymap.set("n", "<leader>vw", function()
						vim.lsp.buf.workspace_symbol()
					end, opts)
					-- open a quick diagnostic info on error/warning under the cursor
					vim.keymap.set("n", "<leader>vd", function()
						vim.diagnostic.open_float()
					end, opts)
					-- goto next diagnostic in file
					vim.keymap.set("n", "[d", function()
						vim.diagnostic.goto_next()
					end, opts)
					-- goto prev diagnostic in file
					vim.keymap.set("n", "]d", function()
						vim.diagnostic.goto_prev()
					end, opts)
					-- see which code-actions the LSP server offers for the item under the cursor
					-- some LSPs do not provide any code actions
					vim.keymap.set("n", "<leader>ca", function()
						vim.lsp.buf.code_action()
					end, opts)
					-- show all refs to the item under the cursor in this file
					vim.keymap.set("n", "<leader>vr", function()
						vim.lsp.buf.references()
					end, opts)
					-- rename the var under the cursor everywhere it occurs in the file
					vim.keymap.set("n", "<leader>vn", function()
						vim.lsp.buf.rename()
					end, opts)
					-- when you are over a function call, show its signature/params
					vim.keymap.set("n", "<leader>ms", function()
						vim.lsp.buf.signature_help()
					end, opts)
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
					"html",
					"htmx",
					"jsonls",
					"markdown_oxide",
					"pyright",
					"sqlls",
					"ts_ls",
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
						"htmlhint",
						"stylelint",
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
					["<D-l>"] = cmp.mapping.select_prev_item(cmp_select),
					["<D-j>"] = cmp.mapping.select_next_item(cmp_select),
					["<D-u>"] = cmp.mapping.scroll_docs(-4),
					["<D-d>"] = cmp.mapping.scroll_docs(4),
					["<D-i>"] = cmp.mapping.confirm({ select = true }),
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

			vim.diagnostic.config({
				virtual_text = true,
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
				print("Diagnostic config applied"),
			})
		end,
	},

	-- for useless animations
	{
		"eandrju/cellular-automaton.nvim",
		config = function()
			vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")
			vim.keymap.set("n", "<leader>gl", "<cmd>CellularAutomaton game_of_life<CR>")
		end,
	},

	-- Trouble for diagnostics
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
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>qf",
				"<cmd>Trouble qflist toggle <cr>",
				desc = "Quickfix List (Trouble)",
			},
			{
				"<leader>ts",
				"<cmd>Trouble symbols toggle win.position=bottom <cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>td",
				"<cmd>Trouble lsp toggle win.position=bottom <cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>tl",
				"<cmd>Trouble loclist toggle <cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>tdo",
				"<cmd>Trouble todo toggle <cr>",
				desc = "Open todos in trouble",
			},
		},
	},

	-- Zen mode
	{
		"folke/zen-mode.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.keymap.set("n", "<leader>zz", function()
				require("zen-mode").setup({
					window = {
						width = 90,
						options = {},
					},
				})
				require("zen-mode").toggle()
				vim.wo.wrap = false
				vim.wo.number = true
				vim.wo.rnu = true
				cme("nord")
			end)

			vim.keymap.set("n", "<leader>zs", function()
				require("zen-mode").setup({
					window = {
						width = 80,
						options = {},
					},
				})
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
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {},
	},

	{
		-- formatting plugin
		"stevearc/conform.nvim",
		-- load the LSP whenever we open a new buffer for a pre-existing file or for a new file
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
				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				},
			})

			-- this is a keymap for formatting a file or a range of text
			-- in normal mode this will format entire file
			-- in visual mode this will format the highlighted text
			vim.keymap.set({ "n", "v" }, "<leader>mp", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "Format file (in normal mode) or range (in visual mode)" })
		end,
	},

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
				html = { "htmlhint" },
				css = { "stylelint" },
				json = { "jsonlint" },
				yaml = { "yamllint" },
				markdown = { "markdownlint" },
				sql = { "sqlfluff" },
				git = { "gitlint" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			-- linting will run on these events
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})

			-- keymap to trigger linting manually
			vim.keymap.set("n", "<leader>li", function()
				lint.try_lint()
			end, { desc = "Trigger linting for current file" })
		end,
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
				chat_shortcut_respond = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g><C-g>" },
				chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>d" },
				chat_shortcut_stop = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>s" },
				chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>c" },

				-- how to display GpChatToggle or GpContext: popup / split / vsplit / tabnew
				toggle_target = "vsplit",
			}
			require("gp").setup(conf)

			-- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
		end,
	},
}
