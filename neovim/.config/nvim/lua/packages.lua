-- bootstrapping packer
local fn=vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	Packer_Bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)

	--startup speed
	use 'lewis6991/impatient.nvim'

	--base plugins.

	use 'wbthomason/packer.nvim'

	use { 'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config=function() require('nvim-treesitter').setup{
			ensure_installed='maintained',
			highlight={enable=true},
			indent={enable=true},
			incremental_selection={enable=true}
		}end,
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
						"sumneko_lua",
						"rust_analyzer",
						'pyright',
						'bashls',
						'texlab'
					},
					automatic_installation=true
				})
			end
		},
		{
			"neovim/nvim-lspconfig",
			after = "mason-lspconfig.nvim",
			after = "rust-tools.nvim",
			config = function()
				require('LSPconfig')
			end
		},
		{'simrat39/rust-tools.nvim',},
		{'mfussenegger/nvim-jdtls',},
	}

	use {'hrsh7th/nvim-cmp',
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

	use {'L3MON4D3/LuaSnip',
		requires={
			'rafamadriz/friendly-snippets'
		},
		config=function()
			require("luasnip.loaders.from_snipmate").load()
			require("luasnip.loaders.from_vscode").load()
		end
	}

	use {'nvim-telescope/telescope.nvim',
		requires = {
			{'nvim-lua/plenary.nvim'},
			{'nvim-lua/popup.nvim'},
			{'nvim-treesitter/nvim-treesitter'},
			{'nvim-telescope/telescope-symbols.nvim'},
			{'nvim-telescope/telescope-file-browser.nvim'},
			{'folke/trouble.nvim'},
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

	--file browser
	use {'kyazdani42/nvim-tree.lua',
		requires = {
		  'kyazdani42/nvim-web-devicons', -- optional, for file icon
		},
		config = function() require'nvim-tree'.setup {
			view={mappings={list={
				{ key = {"<CR>", "o", "<2-LeftMouse>"}, action = "edit" },
				{ key = "<C-e>", action = "edit_in_place" },
				{ key = {"O"}, action = "edit_no_picker" },
				{ key = {"<2-RightMouse>", "<C-]>"},    action = "cd" },
				{ key = "<C-v>", action = "vsplit" },
				{ key = "<C-x>", action = "split" },
				{ key = "<C-t>", action = "tabnew" },
				{ key = "<", action = "prev_sibling" },
				{ key = ">", action = "next_sibling" },
				{ key = "P", action = "parent_node" },
				{ key = "<BS>", action = "close_node" },
				{ key = "<Tab>", action = "preview" },
				{ key = "K", action = "first_sibling" },
				{ key = "J", action = "last_sibling" },
				{ key = "I", action = "toggle_ignored" },
				{ key = "H", action = "toggle_dotfiles" },
				{ key = "R", action = "refresh" },
				{ key = "a", action = "create" },
				{ key = "d", action = "remove" },
				{ key = "D", action = "trash" },
				{ key = "r", action = "rename" },
				{ key = "<C-r>", action = "full_rename" },
				{ key = "x", action = "cut" },
				{ key = "c", action = "copy" },
				{ key = "p", action = "paste" },
				{ key = "y", action = "copy_name" },
				{ key = "Y", action = "copy_path" },
				{ key = "gy", action = "copy_absolute_path" },
				{ key = "[c", action = "prev_git_item" },
				{ key = "]c", action = "next_git_item" },
				{ key = "-", action = "dir_up" },
				{ key = "s", action = "system_open" },
				{ key = "q", action = "close" },
				{ key = "g?", action = "toggle_help" },
				{ key = "W", action = "collapse_all" }
			}}}
		} end
	}

	--UI stuff

	use {'simrat39/symbols-outline.nvim',
		config=function()
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

	use {'stevearc/dressing.nvim',
		config=function()
			require('dressing').setup{}
		end
	}

	use {'nvim-lualine/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true},
		config=function() require('lualine').setup{
			options={
				icons_enabled = true,
				theme = 'auto',
				component_separators = { left = '', right = ''},
				section_separators = { left = '', right = ''},
				disabled_filetypes = {},
				always_divide_middle = true,
			},
			sections = {
				lualine_a = {'mode'},
				lualine_b = {'branch', 'diff', 'diagnostics'},
				lualine_c = {'filename'},
				lualine_x = {'encoding', 'fileformat', 'filetype'},
				lualine_y = {'progress'},
				lualine_z = {'location'}
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {'filename'},
				lualine_x = {'location'},
				lualine_y = {},
				lualine_z = {}
			},
			extensions = {}
		} end,
	}

	use {'kdheepak/tabline.nvim',
		config = function()
			require'tabline'.setup {
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
			vim.cmd[[
			set guioptions-=e " Use showtabline in gui vim
			set sessionoptions+=tabpages,globals " store tabpages and globals in session
			]]
		end,
		requires = { { 'hoob3rt/lualine.nvim', opt=true }, {'kyazdani42/nvim-web-devicons', opt = true} }
	}

	use {'folke/trouble.nvim',
		requires = "kyazdani42/nvim-web-devicons",
		config = function() require("trouble").setup {
				position = "bottom", -- position of the list can be: bottom, top, left, right
				height = 10, -- height of the trouble list when position is top or bottom
				width = 50, -- width of the list when position is left or right
				icons = true, -- use devicons for filenames
				mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
				fold_open = "", -- icon used for open folds
				fold_closed = "", -- icon used for closed folds
				group = true, -- group results by file
				padding = true, -- add an extra new line on top of the list
				action_keys = { -- key mappings for actions in the trouble list
					-- map to {} to remove a mapping, for example:
					-- close = {},
					close = "q", -- close the list
					cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
					refresh = "r", -- manually refresh
					jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
					open_split = { "<c-x>" }, -- open buffer in new split
					open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
					open_tab = { "<c-t>" }, -- open buffer in new tab
					jump_close = {"o"}, -- jump to the diagnostic and close the list
					toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
					toggle_preview = "P", -- toggle auto_preview
					hover = "K", -- opens a small popup with the full multiline message
					preview = "p", -- preview the diagnostic location
					close_folds = {"zM", "zm"}, -- close all folds
					open_folds = {"zR", "zr"}, -- open all folds
					toggle_fold = {"zA", "za", '<space>'}, -- toggle fold of current file
					previous = "k", -- previous item
					next = "j" -- next item
				},
				indent_lines = true, -- add an indent guide below the fold icons
				auto_open = false, -- automatically open the list when you have diagnostics
				auto_close = false, -- automatically close the list when you have no diagnostics
				auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
				auto_fold = false, -- automatically fold a file trouble list at creation
				auto_jump = {"lsp_definitions"}, -- for the given modes, automatically jump if there is only a single result
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

	use {'romgrk/nvim-treesitter-context',
		requires = 'nvim-treesitter/nvim-treesitter',
		config=function() require('treesitter-context').setup{
			enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
			max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
			trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
			min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
			zindex = 200, -- The Z-index of the context window
			mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
			-- Separator between context and content. Should be a single character string, like '-'.
			-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
			separator = nil,
		} end
	}

	use {'lewis6991/gitsigns.nvim',
		-- tag = 'release', -- To use the latest release. currently bugged
		config=function() require('gitsigns').setup() end
	}

	use 'chentau/marks.nvim'

	use 'tversteeg/registers.nvim'

	use {'lukas-reineke/indent-blankline.nvim',
		config=function()
			vim.opt.list = true
			vim.opt.listchars:append("eol:↴")
			require('indent_blankline').setup{
				show_end_of_line=true,
				show_current_context=true
			}
		end
	}

	--editing utilities

	use {'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}

	use "jbyuki/venn.nvim"

	--color scheme stuff.

	use 'bluz71/vim-moonfly-colors'

	use 'bluz71/vim-nightfly-guicolors'

	if Packer_Bootstrap then
		require('packer').sync()
	end
end)
