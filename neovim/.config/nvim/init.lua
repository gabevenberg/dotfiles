--set some aliases to make typing this faster.
local cmd=vim.cmd
local opt=vim.opt
local fn=vim.fn
local map=vim.api.nvim_set_keymap

--helper functions
	local function keyCode(string)
		return vim.api.nvim_replace_termcodes(str, true, true, true, true)
	end

--bootstrapping paq-nvim
	local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
	  fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
	end

--options using vim.opt (aliased, of course.)
	opt.lazyredraw=true
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
	cmd([[source ~/.config/nvim/foldtext.vimrc]])
	opt.foldmethod='indent'
	opt.foldtext='minimal_foldtext()'
	opt.fillchars='stl:=,stlnc: ,vert:|,fold:-'
	opt.foldcolumn='4'
	opt.foldenable=true
	opt.foldminlines=2
	opt.foldignore=''

--leader key is set through a variable, for some reason.
vim.g.mapleader = '\\'

--sets colorscheme. to get a list of avalible options, do colorscheme <Space> <C-d>
vim.g.colors_name='default'

--keyboard mappings
	--toggle spell check
	map('', '<leader>ss', ':setlocal spell!<CR>', {noremap=true, silent=true})
	--easily create splits
	map('', '<leader>|', ':vs<CR>', {noremap=true, silent=true})
	map('', '<leader>-', ':sp<CR>', {noremap=true, silent=true})
	--use ctrl+direction to move between splits.
	map('', '<C-h>', '<C-w>h', {noremap=true, silent=true})
	map('', '<C-j>', '<C-w>j', {noremap=true, silent=true})
	map('', '<C-k>', '<C-w>k', {noremap=true, silent=true})
	map('', '<C-l>', '<C-w>l', {noremap=true, silent=true})
	--toggle folds with space.
	map('', '<Space>', 'za', {noremap=true, silent=true})
	--clear highlighting with leader+l
	map('', '<leader>l', ':nohls<CR>', {noremap=true, silent=true})
