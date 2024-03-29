"Customized vim/neovim config
"Copyright 2018 Gabe Venberg

"This program is free software: you can redistribute it and/or modify
"it under the terms of the GNU General Public License as published by
"the Free Software Foundation, either version 3 of the License, or
"(at your option) any later version.
"
"This program is distributed in the hope that it will be useful,
"but WITHOUT ANY WARRANTY; without even the implied warranty of
"MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"GNU General Public License for more details.
"
"You should have received a copy of the GNU General Public License
"along with this program.  If not, see <http://www.gnu.org/licenses/>.

"this sets what sort of folding method to use.
let foldtype="indent" 
set lazyredraw
set autoread
set history=5000
filetype plugin on
set noswapfile "disables creation of swap files

"useful keybinds
    let mapleader = "\\"
    "spell checking
        "toggle spell checking
        noremap <leader>ss :setlocal spell!<CR>

    "splitting panels with <leader>| or -
        nnoremap <leader>\| :vs<Enter>
        nnoremap <leader>\- :sp<Enter>

        " shortcuts using leader
        " noremap <leader>sn ]s
        " noremap <leader>sp [s
        " noremap <leader>s? z=

        "navigating splits: Control+hjkl will move from split to split
            nnoremap <C-h> <C-w>h
            nnoremap <C-j> <C-w>j
            nnoremap <C-k> <C-w>k
            nnoremap <C-l> <C-w>l

        "command mode keybinds
            "w!! writes using sudo
            "cnoremap w!! w !sudo tee % >/dev/null

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
    set timeout timeoutlen=1000 ttimeout ttimeoutlen=100

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
    noremap <leader>l :nohls<CR>
