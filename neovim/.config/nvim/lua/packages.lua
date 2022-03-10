-- bootstrapping packer
local fn=vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	Packer_Bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)

	--base plugins.

	use 'wbthomason/packer.nvim'

	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config=function() require('nvim-treesitter').setup{
			ensure_installed='maintained',
			highlight={enable=true},
			indent={enable=true},
			incremental_selection={enable=true}
		}end,

	}

	use 'neovim/nvim-lspconfig'

	use {'hrsh7th/nvim-cmp',
		requires = {
			'neovim/nvim-lspconfig',
			'hrsh7th/cmp-nvim-lsp',
			'saadparwaiz1/cmp_luasnip',
			'L3MON4D3/LuaSnip'
		}
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
			{'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
			{'nvim-telescope/telescope-symbols.nvim'},
			{'nvim-telescope/telescope-file-browser.nvim'},
		},
		config=function()
			require'telescope'.load_extension('fzf')
		end
	}

	use {'kyazdani42/nvim-tree.lua',
		requires = {
		  'kyazdani42/nvim-web-devicons', -- optional, for file icon
		},
		config = function() require'nvim-tree'.setup {
			view={mapping={
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
			}}
		} end
	}

	--UI stuff

	use {'simrat39/symbols-outline.nvim',
	config=function() vim.g.symbols_outline={
		width=25,
		relative_width=false
	}end
	}

	use 'yamatsum/nvim-cursorline'

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
			tabline = {},
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

	use {
	  "folke/trouble.nvim",
	  requires = "kyazdani42/nvim-web-devicons",
	  config = function()
		require("trouble").setup {
		}
	  end
	}

	use {'romgrk/nvim-treesitter-context',
		requires = 'nvim-treesitter/nvim-treesitter',
	}

	use {'lewis6991/gitsigns.nvim',
		requires = {'nvim-lua/plenary.nvim'},
		tag = 'release', -- To use the latest release
		config=function() require('gitsigns').setup() end
	}

	use 'chentau/marks.nvim'

	use 'tversteeg/registers.nvim'

	use {'lewis6991/spellsitter.nvim',
		config=function() require('spellsitter').setup() end
	}

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

	--misc

	use {
		'xeluxee/competitest.nvim',
		requires = 'MunifTanjim/nui.nvim',
		config = function() require'competitest'.setup() end
	}

	use {'folke/todo-comments.nvim',
		requires = 'nvim-lua/plenary.nvim',
		config = function()
			require('todo-comments').setup()
		end
	}

	use {'sudormrfbin/cheatsheet.nvim',

		requires = {
			{'nvim-telescope/telescope.nvim'},
			{'nvim-lua/popup.nvim'},
			{'nvim-lua/plenary.nvim'},
		}
	}

	--color scheme stuff.

	use 'bluz71/vim-moonfly-colors'

	use 'bluz71/vim-nightfly-guicolors'

	--language specific tools.

	use 'simrat39/rust-tools.nvim'

	if Packer_Bootstrap then
		require('packer').sync()
	end
end)
