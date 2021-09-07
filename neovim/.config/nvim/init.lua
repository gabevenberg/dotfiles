--set some aliases to make typing this faster.
local cmd=vim.cmd
local opt=vim.opt
local fn=vim.fn
--source any legacy code that I havent ported to lua yet.
cmd([[source ~/.config/nvim/legacy.vimrc]])

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
