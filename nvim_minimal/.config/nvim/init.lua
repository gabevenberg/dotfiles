--set some aliases to make typing this faster.
local cmd = vim.cmd
local opt = vim.opt
local fn = vim.fn
local map = vim.keymap.set

--leader key is set through a variable, for some reason.
vim.g.mapleader = ';'


--helper functions
local function keyCode(string)
	return vim.api.nvim_replace_termcodes(str, true, true, true, true)
end

--options using vim.opt (aliased, of course.)
opt.mouse = 'a'
opt.lazyredraw = true
opt.termguicolors = true
opt.autoread = true
opt.swapfile = false
opt.history = 500
opt.formatoptions = 'rojq'
--disable hard text wrapping, will only wrap visually.
opt.textwidth = 0
opt.wrapmargin = 0
opt.wrap = true
-- opt.linebreak = true
opt.breakindent = true
--highlight after col
opt.colorcolumn = "80,100,120"
--add ruler to side of screen.
opt.number = true
opt.numberwidth=3
--displays cordinates of your cursor in statusbar
opt.ruler = true
--always leave 5 cells between cursor and side of window.
opt.scrolloff = 5
--better command line completion
opt.wildmenu = true
--ignore case in search if search is all lowercase.
opt.ignorecase = true
opt.smartcase = true
--show unfinished commands in statusbar.
opt.showcmd = true
--regex stuff
opt.magic = true
--always have a status line
opt.laststatus = 2
--tab stuff
opt.tabstop = 4
opt.shiftwidth = 0 --zero inherrits tabstop.
opt.autoindent = true
opt.smartindent = true
opt.smarttab = true
--space based tabs.
-- opt.softtabstop=-1 --negative value inherrits shiftwidth.
-- opt.expandtab=true
--highlight search results as you type.
opt.hlsearch = true
opt.incsearch = true
--foling stuff
opt.foldlevelstart = 5
cmd([[source ~/.config/nvim/foldtext.vimrc]])
opt.foldmethod = 'indent'
opt.foldtext = 'minimal_foldtext()'
opt.fillchars = 'stl:=,stlnc: ,vert:|,fold:-'
opt.foldcolumn = 'auto:4'
opt.foldenable = true
opt.foldignore = ''

--keyboard mappings
local function optsWithDesc(desc)
	return {silent=true, desc=desc}
end
local opts = { noremap = true, silent = true }
--toggle spell check
map('n', '<leader>sp', ':setlocal spell!<CR>', optsWithDesc("toggle spell check"))
--buffer stuff (gt and gT are prev/next tab in stock vim)
map('n', 'gf', ':bnext<CR>', optsWithDesc("next buffer"))
map('n', 'gF', ':bprevious<CR>', optsWithDesc("prev buffer"))
--use ctrl+direction to move between splits.
map('n', '<C-h>', '<C-w>h', optsWithDesc("move to split to the right"))
map('n', '<C-j>', '<C-w>j', optsWithDesc("move to split below"))
map('n', '<C-k>', '<C-w>k', optsWithDesc("move to split above"))
map('n', '<C-l>', '<C-w>l', optsWithDesc("move to split to the left"))
--toggle folds with space.
map('n', '<Space>', 'za', optsWithDesc("toggle fold"))
--clear highlighting with leader+h
map('', '<leader>h', ':nohls<CR>', optsWithDesc("clear highlighting"))
--open file browser with leader+t
map('n', '<leader>t', ':Lexplore<CR>', optsWithDesc("toggle file browser"))
