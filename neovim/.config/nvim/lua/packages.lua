local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
			local configs = require('nvim-treesitter.configs')
			configs.setup {
				ensure_installed = {
					'c',
					'lua',
					'vim',
					'vimdoc',
					'query',
					'bash',
					'comment',
					'cpp',
					'diff',
					'git_config',
					'git_rebase',
					'gitattributes',
					'gitcommit',
					'gitignore',
					'json',
					'jsonc',
					'latex',
					'make',
					'python',
					'regex',
					'rust',
					'toml',
				},
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
				incremental_selection = { enable = true }
			}
		end,
	},
	{
		'williamboman/mason.nvim',
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗"
				}
			}
		}
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					'lua_ls',
					'rust_analyzer',
					'bashls',
					'pylsp', -- run PylspInstall pylsp-rope python-lsp-black python-lsp-ruff
					'pyright',
					'texlab',
					'clangd',
				},
				automatic_installation = true
			})
		end
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require('LSPconfig')
		end
	},
	{
		'simrat39/rust-tools.nvim',
	},
	{
		'hrsh7th/nvim-cmp',
		config = function()
			require('cmp-lsp')
		end,
		dependencies = {
			'neovim/nvim-lspconfig',
			'hrsh7th/cmp-nvim-lsp',
			'saadparwaiz1/cmp_luasnip',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'L3MON4D3/LuaSnip',
			'f3fora/cmp-spell',
			'dmitmel/cmp-digraphs',
			'hrsh7th/cmp-nvim-lsp-signature-help',
			'kdheepak/cmp-latex-symbols',
			'hrsh7th/cmp-emoji',
			'ray-x/cmp-treesitter',
			'uga-rosa/cmp-dictionary',
		}
	},
	{
		'L3MON4D3/LuaSnip',
		dependencies = {
			'rafamadriz/friendly-snippets'
		},
		config = function()
			require("luasnip.loaders.from_snipmate").load()
			require("luasnip.loaders.from_vscode").load()
		end
	},
	{
		'nvim-telescope/telescope.nvim',
		config = true,
		dependencies = {
			{ 'nvim-lua/popup.nvim' },
			{ 'nvim-treesitter/nvim-treesitter' },
			{ 'nvim-telescope/telescope-symbols.nvim' },
			{ 'nvim-telescope/telescope-file-browser.nvim' },
		}
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		'kyazdani42/nvim-tree.lua',
		config = true,
		dependencies = {
			'kyazdani42/nvim-web-devicons', -- optional, for file icon
		},
	},
	{
		'ggandor/leap.nvim',
		config = function()
			require('leap').add_default_mappings()
		end
	},
	{
		'folke/which-key.nvim',
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			-- default kemaps that whitch-key misses.
			local wk = require("which-key")
			wk.register {
				g = {
					t = "next tab",
					T = "previous tab"
				},
			}
			require("which-key").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
				-- local wk = require("which-key")
			}
		end
	},
	{
		"akinsho/toggleterm.nvim",
		opts = {
			insert_mappings = false,
			terminal_mappings = false,
			open_mapping = [[<c-\>]],
		}
	},
	{
		'simrat39/symbols-outline.nvim',
		opts = {
			highlight_hovered_item = true,
			show_guides = true,
			auto_preview = false,
			position = 'right',
			relative_width = true,
			width = 30,
			auto_close = false,
			show_numbers = false,
			show_relative_numbers = false,
			show_symbol_details = true,
			preview_bg_highlight = 'Pmenu',
			autofold_depth = nil,
			auto_unfold_hover = true,
			fold_markers = { '', '' },
			wrap = false,
		}
	},
	{
		'stevearc/dressing.nvim',
		config = true,
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'kyazdani42/nvim-web-devicons' },
		opts = {
			options = {
				icons_enabled = true,
				theme = 'auto',
				component_separators = { left = '', right = '' },
				section_separators = { left = '', right = '' },
				disabled_filetypes = {},
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { 'mode' },
				lualine_b = { 'branch', 'diff', 'diagnostics' },
				lualine_c = { { 'filename', path = 1, } },
				lualine_x = { 'encoding', 'fileformat', 'filetype' },
				lualine_y = { 'progress' },
				lualine_z = { 'location' }
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { 'filename' },
				lualine_x = { 'location' },
				lualine_y = {},
				lualine_z = {}
			},
			tabline = {
				lualine_a = { { 'buffers', mode = 4 } },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { { 'tabs', mode = 2 } }
			},
			winbar = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {}
			},
			inactive_winbar = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {}
			},
			extensions = {}
		},

	},
	{
		'romgrk/nvim-treesitter-context',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		opts = {
			enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
			max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
			trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
			min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
			zindex = 200, -- The Z-index of the context window
			mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
			-- Separator between context and content. Should be a single character string, like '-'.
			-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
			separator = nil,
		}
	},
	{
		'hiphish/rainbow-delimiters.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		config = function()
			local rainbow_delimiters = require 'rainbow-delimiters'
			vim.g.rainbow_delimiters = {
				strategy = {
					[''] = rainbow_delimiters.strategy['global'],
				},
				query = {
					[''] = 'rainbow-delimiters',
					lua = 'rainbow-blocks',
				},
				highlight = {
					'RainbowDelimiterViolet',
					'RainbowDelimiterCyan',
					'RainbowDelimiterYellow',
					'RainbowDelimiterBlue',
					'RainbowDelimiterOrange',
					'RainbowDelimiterGreen',
					-- 'RainbowDelimiterRed',
				}
			}
		end
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {}
	},
	{
		'lewis6991/gitsigns.nvim',
		config = true,
	},
	{
		'chentoast/marks.nvim',
		config = true
	},
	'sitiom/nvim-numbertoggle',
	{
		'numToStr/Comment.nvim',
		config = true,
	},
	{
		'Wansmer/treesj',
		dependencies = { 'nvim-treesitter' },
		opts = {
			-- Use default keymaps
			-- (<space>m - toggle, <space>j - join, <space>s - split)
			use_default_keymaps = false,
			max_join_length = 256,
		}
	},
	"jbyuki/venn.nvim",

	--colorscheme
	{
		'bluz71/vim-moonfly-colors',
		lazy = true,
	},

	{
		'bluz71/vim-nightfly-guicolors',
		lazy = true,
	},
	{
		'AlexvZyl/nordic.nvim',
		lazy = true,
	},
	{
		'savq/melange-nvim',
		lazy = true,
	},
	{
		"folke/tokyonight.nvim",
		lazy = true,
	},
	{
		'nyoom-engineering/oxocarbon.nvim',
		lazy = true,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
	},
	{
		'rebelot/kanagawa.nvim',
		lazy = true,
	},
	{
		'ellisonleao/gruvbox.nvim',
		lazy = true,
	},

})
