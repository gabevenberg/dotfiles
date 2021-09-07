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

filetype plugin on

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

"highlighting/colour stuff
	"sets the colorscheme. to get a list of the available colors, do :colorscheme <Space> <C-d>
	colorscheme ron 

	syntax enable

	"<leader> L clears the search highlighting
	noremap <leader>l :nohls<CR>

"neovim stuff
"	if has('nvim')
"		set guicursor=
"	endif

"folding stuff TODO: implement other folding methods.

	"spacebar opens or closes a fold in normal mode
	noremap <Space> za
