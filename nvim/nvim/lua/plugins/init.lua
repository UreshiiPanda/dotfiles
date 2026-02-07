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
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
			},
			{
				"folke/todo-comments.nvim",
				event = { "BufReadPre", "BufNewFile" },
				dependencies = { "nvim-lua/plenary.nvim" },
				config = function()
					local todo_comments = require("todo-comments")
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
					-- Performance optimizations
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
						"--glob=!.git/",
						"--glob=!node_modules/",
					},
					file_ignore_patterns = { ".git/", "node_modules/", ".DS_Store" },
					-- Speed improvements
					sorting_strategy = "descending",
					cache_picker = {
						num_pickers = 10,
					},
				},
				pickers = {
					find_files = {
						find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*", "--glob", "!node_modules/*" },
					},
					live_grep = {
						additional_args = function()
							return { "--hidden", "--glob", "!.git/*", "--glob", "!node_modules/*" }
						end,
					},
				},
			})
			-- Load fzf extension for massive performance boost
			telescope.load_extension("fzf")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>f", function()
				builtin.find_files({
					no_ignore = true,
					hidden = true,
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

	-- UndoTree
	{
		"mbbill/undotree",
		event = "VeryLazy", -- Pre-load instead of waiting for command
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "UndoTree: Toggle undo tree" },
			{ "<leader>uf", "<cmd>UndotreeFocus<CR>", desc = "UndoTree: Focus undo tree" },
		},
		config = function()
			vim.g.undotree_WindowLayout = 2
			vim.g.undotree_SetFocusWhenToggle = 1
			vim.g.undotree_ShortIndicators = 1 -- Faster rendering
			vim.g.undotree_DiffAutoOpen = 0
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
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim", event = { "BufReadPre", "BufNewFile" } },
			{ "williamboman/mason-lspconfig.nvim", event = { "BufReadPre", "BufNewFile" } },
			{ "WhoIsSethDaniel/mason-tool-installer.nvim", event = { "BufReadPre", "BufNewFile" } },
			{ "hrsh7th/cmp-nvim-lsp", event = { "BufReadPre", "BufNewFile" } },
			{ "hrsh7th/cmp-buffer", event = { "BufReadPre", "BufNewFile" } },
			{ "hrsh7th/cmp-path", event = { "BufReadPre", "BufNewFile" } },
			{ "hrsh7th/cmp-cmdline", event = { "BufReadPre", "BufNewFile" } },
			{
				"hrsh7th/nvim-cmp",
				event = "InsertEnter",
			},
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				build = "make install_jsregexp",
			},
			{ "saadparwaiz1/cmp_luasnip", event = { "BufReadPre", "BufNewFile" } },
			{ "rafamadriz/friendly-snippets", event = { "BufReadPre", "BufNewFile" } },
			{ "onsails/lspkind.nvim", event = { "BufReadPre", "BufNewFile" } },
			{ "j-hui/fidget.nvim", event = { "BufReadPre", "BufNewFile" } },
		},
		config = function()
			-- Configure LSP window borders (modern API)
			require("lspconfig.ui.windows").default_options.border = "rounded"

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
				callback = function(event)
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
						vim.diagnostic.jump({ count = -1, float = true })
					end, { buffer = event.buf, desc = "LSP: Go to previous diagnostic" })
					vim.keymap.set("n", "]d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, { buffer = event.buf, desc = "LSP: Go to next diagnostic" })
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

			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("fidget").setup({})
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
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = lsp_capabilities,
						})
					end,

					lua_ls = function()
						require("lspconfig").lua_ls.setup({
							capabilities = lsp_capabilities,
							settings = {
								Lua = {
									runtime = {
										version = "LuaJIT",
									},
									diagnostics = {
										globals = { "vim" },
									},
									workspace = {
										library = {
											vim.env.VIMRUNTIME,
											vim.fn.expand("$VIMRUNTIME/lua"),
											vim.fn.stdpath("config") .. "/lua",
										},
										checkThirdParty = false,
									},
								},
							},
						})
					end,

					sourcekit = function()
						require("lspconfig").sourcekit.setup({
							capabilities = lsp_capabilities,
						})
					end,
				},
			})

			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				completion = {
					completeopt = "menu,menuone,preview,noselect",
				},

				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "luasnip", keyword_length = 2 },
					{ name = "buffer", keyword_length = 3 },
				},

				mapping = cmp.mapping.preset.insert({
					["<D-k>"] = cmp.mapping.select_prev_item(cmp_select),
					["<D-j>"] = cmp.mapping.select_next_item(cmp_select),
					["<D-u>"] = cmp.mapping.scroll_docs(-4),
					["<D-d>"] = cmp.mapping.scroll_docs(4),
					["<D-;>"] = cmp.mapping.confirm({ select = true }),
					["<D-f>"] = cmp.mapping.complete(),
				}),

				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},

				formatting = {
					format = require("lspkind").cmp_format({
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},

				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			})
		end,
	},

	-- Cellular Automaton
	{
		"eandrju/cellular-automaton.nvim",
		cmd = { "CellularAutomaton" },
		keys = {
			{
				"<leader>mr",
				"<cmd>CellularAutomaton make_it_rain<CR>",
				desc = "Cellular-Automaton: Make it rain effect",
			},
			{ "<leader>gl", "<cmd>CellularAutomaton game_of_life<CR>", desc = "Cellular-Automaton: Game of Life" },
		},
		config = function()
			-- Config removed - keymaps now in keys table above for lazy loading
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

	{
		-- neorg/ norg
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
					["core.esupports.indent"] = {
						config = {
							dedent_excess = false,
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
		event = "VeryLazy",
		opts = {
			styles = {
				snacks_image = {
					relative = "cursor",
					border = "rounded",
					focusable = false,
					backdrop = false,
					row = 1,
					col = 1,
				},
			},

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
				force = true,
				env = {
					SNACKS_KITTY = true,
				},
				doc = {
					enabled = true,
					inline = false,
					float = true,
					max_width = 60,
					max_height = 30,
				},
				img_dirs = { vim.fn.expand("~/image_notes") },
			},

			-- explicitly disable everything else
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
		},
	},

	-- Image paste functionality with img-clip.nvim
	{
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		opts = {
			default = {
				-- Save images to ~/image_notes directory
				dir_path = vim.fn.expand("~/image_notes"),
				-- These settings don't seem to be working as expected
				relative_to_current_file = false,
				use_absolute_path = false,
				file_name = function()
					return "image_" .. os.date("%Y%m%d%H%M%S")
				end,
				extension = "png",
				-- The key fix: override the template to directly use the tilde path
				template = function(context)
					-- Get just the filename portion
					local filename = vim.fn.fnamemodify(context.file_path, ":t")
					-- Return the template with a hardcoded tilde path
					return ".image ~/image_notes/" .. filename .. "\n$CURSOR"
				end,
				insert_mode_after_paste = true,
				prompt_for_file_name = false,
				copy_images = true,
				download_images = true,
			},
			-- Filetype-specific options (note we're overriding the norg template)
			filetypes = {
				markdown = {
					template = function(context)
						local filename = vim.fn.fnamemodify(context.file_path, ":t")
						return "![Image](~/image_notes/" .. filename .. ")"
					end,
					url_encode_path = false,
				},
				html = {
					template = function(context)
						local filename = vim.fn.fnamemodify(context.file_path, ":t")
						return '<img src="~/image_notes/' .. filename .. '" alt="Image">'
					end,
				},
				norg = {
					template = function(context)
						local filename = vim.fn.fnamemodify(context.file_path, ":t")
						return ".image ~/image_notes/" .. filename .. "\n$CURSOR"
					end,
					url_encode_path = false,
				},
			},
			drag_and_drop = {
				enabled = true,
				insert_mode = false,
			},
		},
		keys = {
			{ "<leader>ip", "<cmd>PasteImage<cr>", desc = "Paste image from clipboard" },
		},
		config = function(_, opts)
			local image_dir = vim.fn.expand("~/image_notes")
			if vim.fn.isdirectory(image_dir) == 0 then
				vim.fn.mkdir(image_dir, "p")
			end

			require("img-clip").setup(opts)
		end,
	},
}
