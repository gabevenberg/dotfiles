"

"this sets what sort of folding method to use.
let foldtype="basicindent" 
set lazyredraw
set autoread
set history=5000
filetype plugin on

"user interface stuff
	"disables the autocommenting stuff.
		set formatoptions-=o
		set formatoptions-=r
		set formatoptions-=c

	"disable text wrapping via carriage returns, should only wrap visually 
		set textwidth=0
		set wrapmargin=0
		set wrap
		set linebreak
		set breakindent

	"adds a ruler to the side of the screen
	set number

	"makes the ruler show how many lines away a given line is from your cursor
	"set relativenumber

	"displays the coordinates of your cursour in the statusbar
	set ruler

	"scrollofff sets the number of lines from the top or bottom of the screen before vim will scroll. sidescroll off does the same thing for the sides of the window
	set scrolloff=5
	set sidescrolloff=5

	"better command line completion
	set wildmenu

	"ignore cases in search unless you have a capital letter in the search
	set ignorecase
	set smartcase

	"this allows putting the cursor just after the last character of the line.
	"set virtualedit=onemore

	"show unfinished commands on the RIGHT side of the statusbar. yes, it is working.
	set showcmd 

	"make regex a bit easier to type
		set magic
		set hidden

	"always display status line
	set laststatus=2

	"keycodes time out fast, mappings have a bit longer
	set timeout timeoutlen=50 ttimeout ttimeoutlen=5

	"make it so the session feature wont overwrite our vimrc if the vimrc has newer bindings than this session.
	set sessionoptions-=options 

"tab stuff
	set tabstop=4
	set shiftwidth=4
	set autoindent

"highlighting/colour stuff
	"sets the colorscheme. to get a list of the available colors, do :colorscheme <Space> <C-d>
	colorscheme ron 

	syntax enable


	"highlight search results
	set hlsearch

	"search as you type
	set incsearch

	"<leader> L clears the search highlighting
	noremap <leader>l :nohls<Enter> 

"neovim stuff
	if has('nvim')
		set guicursor=
	endif

"folding stuff TODO: implement other folding methods.
	"give a bit of margin space for fold number
	set foldcolumn=3

	set foldenable

	"set the minimum number of screen lines for a fold to be closable.
	set foldminlines=3

	"spacebar opens or closes a fold in normal mode
	nnoremap <Space> za
	vnoremap <Space> za

	"indent folding: really basic fold method. eventually I may make some custom folds, but with the foldtext fixed a bit, this shouldn't annoy me too much.
	if foldtype ==# "basicindent"
		"make vim fold automatically based on indentation.
		set foldmethod=indent
		"make sure that comment are counted in indent folding!
		set foldignore=
		set fillchars="fold:-"
		"set the fold text for this method, in most cases, the line just above our fold is what we want, so we wont put any text into it. just level and linecount. TODO
		function! Minimal_foldtext()
			let lines_count = v:foldend - v:foldstart
			let lines_count_text = '+' . v:folddashes . '| ' . printf("%10S" , lines_count) . ' lines |'
			let line_level_text = '| ' . printf("%5S" , 'level ' . v:foldlevel) . ' |'
			let fold_text_end = line_level_text . repeat('-',8)
			let fold_text_length = strlen(lines_count_text . fold_text_end) + &foldcolumn
			return lines_count_text . repeat('-' , winwidth(0) - fold_text_length) . fold_text_end
		endfunction
		set foldtext=Minimal_foldtext()
	endif

"useful keybinds
	"spell checking
		"toggle spell checking
		map <leader>ss :setlocal spell!<Enter>

	"splitting panels with <leader>| or -
		nmap <leader>\| :vs<Enter>
		nmap <leader>\- :sp<Enter>

		" shortcuts using leader
		" noremap <leader>sn ]s
		" noremap <leader>sp [s
		" noremap <leader>s? z=

		"navigating splits: Control+hjkl will move from split to split
			nmap <C-h> <C-w>h
			nmap <C-j> <C-w>j
			nmap <C-k> <C-w>k
			nmap <C-l> <C-w>l

		"command mode keybinds
			"w!! writes using sudo
			"cnoremap w!! w !sudo tee % >/dev/null
