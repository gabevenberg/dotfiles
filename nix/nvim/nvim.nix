{
  configs,
  pkg,
  ...
}: {
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    colorschemes.base16 = {
      colorscheme = "gruvbox-dark-medium";
      enable = true;
    };

    options = {
      mouse = "a";
      lazyredraw = true;
      termguicolors = true;
      autoread = true;
      swapfile = false;
      history = 500;
      formatoptions = "rojq";
      # dont hard wrap
      textwidth = 0;
      wrapmargin = 0;
      breakindent = true;
      # highlight after col
      colorcolumn = "80,100,120";
      # add ruler to side of screen
      number = true;
      numberwidth = 3;
      #display cursor cordinates
      ruler = true;
      #always leave 5 cells between cursor and side of window
      scrolloff = 5;
      # better command line completion
      wildmenu = true;
      # ignore case if all lowercase
      ignorecase = true;
      smartcase = true;
      # show unfinished keycombos in statusbar
      showcmd = true;
      # regex stuff
      magic = true;
      # always show statusline
      laststatus = 2;
      # tab stuff
      tabstop = 4;
      shiftwidth = 0;
      autoindent = true;
      smartindent = true;
      smarttab = true;
      # for true tabs, change to false
      expandtab = true;
      softtabstop = -1;
      # highlight search results as you type
      hlsearch = true;
      incsearch = true;
      # folding stuff
      foldlevelstart = 5;
      foldmethod = "indent";
      foldcolumn = "auto:4";
      foldenable = true;
      # display whitespace as other chars
      list = true;
      listchars = {
        tab = ">-";
        eol = "↲";
        nbsp = "␣";
        trail = "•";
        extends = "⟩";
        precedes = "⟨";
      };
      showbreak = "↪";
    };

    clipboard.providers.xsel.enable = true;

    globals = {
      mapleader = ";";
    };

    keymaps = [
      {
        action = ":setlocal spell!<CR>";
        key = "<leader>cs";
        mode = "n";
        options = {
          silent = true;
          desc = "toggle spell check";
        };
      }
      {
        action = ":bnext<CR>";
        key = "gf";
        mode = "n";
        options = {
          silent = true;
          desc = "next buffer";
        };
      }
      {
        action = ":bprevious<CR>";
        key = "gF";
        mode = "n";
        options = {
          silent = true;
          desc = "prev buffer";
        };
      }
      {
        action = "<C-w>h";
        key = "<C-h>";
        mode = "n";
        options = {
          silent = true;
          desc = "move to right split";
        };
      }
      {
        action = "<C-w>j";
        key = "<C-j>";
        mode = "n";
        options = {
          silent = true;
          desc = "move to below split";
        };
      }
      {
        action = "<C-w>k";
        key = "<C-k>";
        mode = "n";
        options = {
          silent = true;
          desc = "move to above split";
        };
      }
      {
        action = "<C-w>l";
        key = "<C-l>";
        mode = "n";
        options = {
          silent = true;
          desc = "move to left split";
        };
      }
      {
        action = "za";
        key = "<Space>";
        mode = "n";
        options = {
          silent = true;
          desc = "toggle fold";
        };
      }
      {
        action = ":nohls<CR>";
        key = "<leader>h";
        mode = "n";
        options = {
          silent = true;
          desc = "clear highlighting";
        };
      }
    ];
  };
  imports = [
    ./lualine.nix
    ./nvim-tree.nix
    ./toggleterm.nix
  ];
}
