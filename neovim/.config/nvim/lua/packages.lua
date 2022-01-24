-- bootstrapping packer
local fn=vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	Packer_Bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)

	--base plugins.

	use 'wbthomason/packer.nvim'

	use {'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
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
		config = function() require'nvim-tree'.setup {} end
	}

	--UI stuff

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

	use{'eddiebergman/nvim-treesitter-pyfold',
		config=function ()
			require('nvim-treesitter.configs').setup {
				pyfold = {
					enable = true,
					custom_foldtext = true -- Sets provided foldtext on window where module is active
				}
			}
		end
	}

	use 'simrat39/rust-tools.nvim'

	if Packer_Bootstrap then
		require('packer').sync()
	end
end)
