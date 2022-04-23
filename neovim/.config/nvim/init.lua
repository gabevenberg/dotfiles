--set some aliases to make typing this faster.
local cmd=vim.cmd
local opt=vim.opt
local fn=vim.fn
local map=vim.api.nvim_set_keymap

--leader key is set through a variable, for some reason.
vim.g.mapleader = ';'

--do package management
require('impatient')
require('packages')
require('LSPconfig')
require('cmp-lsp')


--helper functions
	local function keyCode(string)
		return vim.api.nvim_replace_termcodes(str, true, true, true, true)
	end

--options using vim.opt (aliased, of course.)
	opt.mouse='a'
	opt.lazyredraw=true
	opt.termguicolors=true
	opt.autoread=true
	opt.swapfile=false
	opt.history=500
	opt.formatoptions='rojq'
	--disable hard text wrapping, will only wrap visually.
	opt.textwidth=0
	opt.wrapmargin=0
	opt.wrap=true
	opt.linebreak=true
	opt.breakindent=true
	--add ruler to side of screen.
	opt.number=true
	--displays cordinates of your cursor in statusbar
	opt.ruler=true
	--always leave 5 cells between cursor and side of window.
	opt.scrolloff=5
	opt.sidescrolloff=5
	--better command line completion
	opt.wildmenu=true
	--ignore case in search if search is all lowercase.
	opt.ignorecase=true
	opt.smartcase=true
	--show unfinished commands in statusbar.
	opt.showcmd=true
	--regex stuff
	opt.magic=true
	--always have a status line
	opt.laststatus=2
	--tab stuff
	opt.tabstop=4
	opt.shiftwidth=4
	opt.autoindent=true
	--highlight search results as you type.
	opt.hlsearch=true
	opt.incsearch=true
	--foling stuff
	opt.foldlevelstart=5
	cmd([[source ~/.config/nvim/foldtext.vimrc]])
	opt.foldmethod='indent'
	opt.foldtext='minimal_foldtext()'
	opt.fillchars='stl:=,stlnc: ,vert:|,fold:-'
	opt.foldcolumn='4'
	opt.foldenable=true
	opt.foldignore=''

--sets colorscheme. to get a list of avalible options, do colorscheme <Space> <C-d>
vim.cmd 'colorscheme moonfly'

--keyboard mappings
	local opts = { noremap=true, silent=true }
	--toggle spell check
	map('n', '<leader>sp', ':setlocal spell!<CR>', opts)
	--[[ --easily create splits
	map('n', '<leader>|', ':vs<CR>', opts) ]]
	--[[ map('n', '<leader>-', ':sp<CR>', opts)
	--use ctrl+direction to move between splits. ]]
	map('n', '<C-h>', '<C-w>h', opts)
	map('n', '<C-j>', '<C-w>j', opts)
	map('n', '<C-k>', '<C-w>k', opts)
	map('n', '<C-l>', '<C-w>l', opts)
	--toggle folds with space.
	map('', '<Space>', 'za', opts)
	--clear highlighting with leader+h
	map('', '<leader>h', ':nohls<CR>', opts)
	--open nvim-tree with leader+t
	map('n', '<leader>t', ':NvimTreeToggle<CR>', opts)
	--open symbols-outline with leader+o
	map('n', '<leader>o', ':SymbolsOutline<CR>', opts)
	--telescope stuff
	map('n', '<leader>ff', ':lua require "telescope".extensions.file_browser.file_browser()<CR>', opts)
	map('n', '<leader>fg', ':Telescope live_grep<CR>', opts)
	map('n', '<leader>fb', ':Telescope buffers<CR>', opts)
	map('n', '<leader>fm', ':Telescope marks<CR>', opts)
	map('n', '<leader>fp', ':Telescope registers<CR>', opts)
	map('n', '<leader>fs', ':Telescope spell_suggest<CR>', opts)
	map('n', '<leader>fh', ':Telescope keymaps<CR>', opts)
	map('n', '<leader>fz', ':Telescope current_buffer_fuzzy_find<CR>', opts)
	map('n', '<leader>fgc', ':Telescope git_commits<CR>', opts)
	map('n', '<leader>fgb', ':Telescope git_branches<CR>', opts)
	map('n', '<leader>fgs', ':Telescope git_stash<CR>', opts)
	map('n', '<leader>ft', ':Telescope treesitter<CR>', opts)
	--Treesitter context
	map('n', '<leader>c', ':TSContextToggle<CR>', opts)
	--tabline stuff (gt and gT are prev/next tab in stock vim)
	map('n', 'gf', ':TablineBufferNext<CR>', opts)
	map('n', 'gF', ':TablineBufferPrevious<CR>', opts)
	--gitsigns
	map('n', '<leader>bl', ':Gitsigns toggle_current_line_blame<CR>', opts)
