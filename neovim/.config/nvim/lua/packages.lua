-- bootstrapping packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	Packer_Bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
		install_path })
end

return require('packer').startup(function(use)
	--startup speed
	use 'lewis6991/impatient.nvim'

	--base plugins.

	use 'wbthomason/packer.nvim'

	use { 'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function()
			require('nvim-treesitter').setup {
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
	}
	use {
		{
			"williamboman/mason.nvim",
			config = function()
				require("mason").setup({
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗"
						}
					}
				})
			end
		},
		{
			"williamboman/mason-lspconfig.nvim",
			after = "mason.nvim",
			config = function()
				require("mason-lspconfig").setup({
					ensure_installed = {
						'lua_ls',
						'rust_analyzer',
						'pyright',
						'bashls',
						'texlab',
						'clangd',
					},
					automatic_installation = true
				})
			end
		},
		{
			"neovim/nvim-lspconfig",
			after = { "mason-lspconfig.nvim", "rust-tools.nvim" },
			config = function()
				require('LSPconfig')
			end
		},
		{ 'simrat39/rust-tools.nvim', },
		{ 'mfussenegger/nvim-jdtls', },
	}

	use { 'hrsh7th/nvim-cmp',
		requires = {
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
		},
		config = function()
			require('cmp-lsp')
		end
	}

	use { 'L3MON4D3/LuaSnip',
		requires = {
			'rafamadriz/friendly-snippets'
		},
		config = function()
			require("luasnip.loaders.from_snipmate").load()
			require("luasnip.loaders.from_vscode").load()
		end
	}

	use { 'nvim-telescope/telescope.nvim',
		requires = {
			{ 'nvim-lua/plenary.nvim' },
			{ 'nvim-lua/popup.nvim' },
			{ 'nvim-treesitter/nvim-treesitter' },
			{ 'nvim-telescope/telescope-symbols.nvim' },
			{ 'nvim-telescope/telescope-file-browser.nvim' },
			{ 'folke/trouble.nvim' },
		},
		config = function()
			local trouble = require("trouble.providers.telescope")
			require('telescope').setup {
				defaults = {
					mappings = {
						i = { ["<c-t>"] = trouble.open_with_trouble },
						n = { ["<c-t>"] = trouble.open_with_trouble },
					},
				},
			}
		end
	}

	use { 'folke/trouble.nvim',
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup {
				position = "bottom", -- position of the list can be: bottom, top, left, right
				height = 10, -- height of the trouble list when position is top or bottom
				width = 50, -- width of the list when position is left or right
				icons = true, -- use devicons for filenames
				mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
				fold_open = "", -- icon used for open folds
				fold_closed = "", -- icon used for closed folds
				group = true, -- group results by file
				padding = true, -- add an extra new line on top of the list
				action_keys = {
					-- key mappings for actions in the trouble list
					-- map to {} to remove a mapping, for example:
					-- close = {},
					close = "q",              -- close the list
					cancel = "<esc>",         -- cancel the preview and get back to your last window / buffer / cursor
					refresh = "r",            -- manually refresh
					jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
					open_split = { "<c-x>" }, -- open buffer in new split
					open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
					open_tab = { "<c-t>" },   -- open buffer in new tab
					jump_close = { "o" },     -- jump to the diagnostic and close the list
					toggle_mode = "m",        -- toggle between "workspace" and "document" diagnostics mode
					toggle_preview = "P",     -- toggle auto_preview
					hover = "K",              -- opens a small popup with the full multiline message
					preview = "p",            -- preview the diagnostic location
					close_folds = { "zM", "zm" }, -- close all folds
					open_folds = { "zR", "zr" }, -- open all folds
					toggle_fold = { "zA", "za", '<space>' }, -- toggle fold of current file
					previous = "k",           -- previous item
					next = "j"                -- next item
				},
				indent_lines = true,          -- add an indent guide below the fold icons
				auto_open = false,            -- automatically open the list when you have diagnostics
				auto_close = false,           -- automatically close the list when you have no diagnostics
				auto_preview = true,          -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
				auto_fold = false,            -- automatically fold a file trouble list at creation
				auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
				signs = {
					-- icons / text used for a diagnostic
					error = "",
					warning = "",
					hint = "",
					information = "",
					other = "﫠"
				},
				use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
			}
		end
	}

	use {
		"folke/todo-comments.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			local opts = {
				-- your configuration comes here
				-- or leave it empty to use the default settings
			}
			require("todo-comments").setup(opts)
		end
	}

	--file browser
	use { 'kyazdani42/nvim-tree.lua',
		requires = {
			'kyazdani42/nvim-web-devicons', -- optional, for file icon
		},
		config = function()
			require 'nvim-tree'.setup {

				on_attach = function(bufnr)
					local api = require('nvim-tree.api')

					local function opts(desc)
						return {
							desc = 'nvim-tree: ' .. desc,
							buffer = bufnr,
							noremap = true,
							silent = true,
							nowait = true
						}
					end


					-- Default mappings. Feel free to modify or remove as you wish.
					--
					-- BEGIN_DEFAULT_ON_ATTACH
					vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
					vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
					vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
					vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
					vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
					vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
					vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
					vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
					vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
					vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
					vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
					vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
					vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
					vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
					vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
					vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
					vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle No Buffer'))
					vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
					vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts('Toggle Git Clean'))
					vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
					vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
					vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
					vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
					vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
					vim.keymap.set('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
					vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
					vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
					vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
					vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
					vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
					vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
					vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
					vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
					vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
					vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
					vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
					vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
					vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
					vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
					vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
					vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
					vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
					vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
					vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
					vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
					vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
					vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
					vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
					vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
					vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
					vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
					vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
					-- END_DEFAULT_ON_ATTACH


					-- Mappings migrated from view.mappings.list
					--
					-- You will need to insert "your code goes here" for any mappings with a custom action_cb
					vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
					vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
					vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
					vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
					vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
					vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
					vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
					vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
					vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
					vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
					vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
					vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
					vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
					vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
					vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
					vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
					vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
					vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
					vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
					vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
					vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
					vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
					vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
					vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
					vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
					vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
					vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
					vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
					vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
					vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
					vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
					vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
					vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
					vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
					vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
					vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
					vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
					vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
				end,
				-- on_attach = on_attach
			}
		end
	}

	use {
		"folke/which-key.nvim",
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
	}

	--UI stuff

	use { "akinsho/toggleterm.nvim", tag = '*', config = function()
		require("toggleterm").setup {
			insert_mappings = false,
			open_mapping = [[<c-\>]],
		}
	end }

	use { 'simrat39/symbols-outline.nvim',
		config = function()
			local opts = {
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
			require("symbols-outline").setup(opts)
		end
	}

	use { 'stevearc/dressing.nvim',
		config = function()
			require('dressing').setup {}
		end
	}

	use { 'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
		config = function()
			require('lualine').setup {
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
					lualine_c = { 'filename' },
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
				extensions = {}
			}
		end,
	}

	use { 'kdheepak/tabline.nvim',
		config = function()
			require 'tabline'.setup {
				-- Defaults configuration options
				enable = true,
				options = {
					-- If lualine is installed tabline will use separators configured in lualine by default.
					-- These options can be used to override those settings.
					-- section_separators = {'', ''},
					-- component_separators = {'', ''},
					-- max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
					show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
					show_devicons = true, -- this shows devicons in buffer section
					show_bufnr = true, -- this appends [bufnr] to buffer section,
					show_filename_only = false, -- shows base filename only instead of relative path in filename
				}
			}
			vim.cmd [[
	set guioptions-=e " Use showtabline in gui vim
	set sessionoptions+=tabpages,globals " store tabpages and globals in session
	]]
		end,
		requires = { { 'hoob3rt/lualine.nvim', opt = true }, { 'kyazdani42/nvim-web-devicons', opt = true } }
	}

	use { 'romgrk/nvim-treesitter-context',
		requires = 'nvim-treesitter/nvim-treesitter',
		config = function()
			require('treesitter-context').setup {
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
		end
	}

	use { 'lewis6991/gitsigns.nvim',
		-- tag = 'release', -- To use the latest release. currently bugged
		config = function() require('gitsigns').setup() end
	}

	use { 'chentau/marks.nvim' }

	use { 'sitiom/nvim-numbertoggle' }

	use { 'lukas-reineke/indent-blankline.nvim',
		config = function()
			vim.opt.list = true
			vim.opt.listchars:append("eol:↴")
			require('indent_blankline').setup {
				show_end_of_line = true,
				show_current_context = true
			}
		end
	}

	--editing utilities

	use { 'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}

	use {
		"tversteeg/registers.nvim",
		config = function()
			require("registers").setup()
		end,
	}

	use { 'Wansmer/treesj',
		requires = { 'nvim-treesitter' },
		config = function()
			require('treesj').setup({
				-- Use default keymaps
				-- (<space>m - toggle, <space>j - join, <space>s - split)
				use_default_keymaps = false,
				max_join_length = 256,
			})
		end,
	}

	use "jbyuki/venn.nvim"

	--color scheme stuff.

	use 'bluz71/vim-moonfly-colors'

	use 'bluz71/vim-nightfly-guicolors'

	if Packer_Bootstrap then
		require('packer').sync()
	end
end)
