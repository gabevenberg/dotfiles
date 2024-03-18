{
  config,
  pkgs,
  lib,
  ...
}: let
  dotfilesDirectory = ~/dotfiles/nix;
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "gabe";
  home.homeDirectory = "/home/gabe";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = [
    pkgs.zellij
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/zellij/config.kdl".source = lib.path.append dotfilesDirectory "zellij/config.kdl";
    ".config/nushell/scripts".source = lib.path.append dotfilesDirectory "nushell/scripts";
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.sessionPath = [
    "$HOME/.local/bin/"
    "$HOME/.cargo/bin/"
    "/opt/"
    "$HOME/.nix-profile/bin/"
  ];

  home.shellAliases = {
    say = "espeak -p 10 -s 150 -a 200";
    tmux = "tmux -u";
    pdfmk = "latexmk -lualatex -pvc";
    doc2pdf = "loffice --convert-to-pdf --headless *.docx";
    sshmnt = "sshfs -o idmap=user,compression=no,reconnect,follow_symlinks,dir_cache=yes,ServerAliveInterval=15";
  };

  programs.git = {
    enable = true;
    aliases = {
      hist = "log --graph --date-order --date=short --pretty=format:'%C(auto)%h%d %C(reset)%s %C(bold blue)%ce %C(reset)%C(green)%cr (%cd)'";
      graph = "log --graph --topo-order --all --pretty=format:'%C(auto)%h %C(cyan)%an %C(blue)%ar %C(auto)%d %s'";
      recent = "branch --sort=-committerdate --format='%(committerdate:relative)%09%(refname:short)'";
    };
    delta.enable = true;
    # difftastic.enable=true;
    # difftastic.background="dark";
    userEmail = "gabevenberg@gmail.com";
    userName = "Gabe Venberg";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      push = {
        autoSetupRemote = true;
        default = "current";
      };
      pull = {
        ff = true;
      };
      merge = {
        conflictstyle = "zdiff3";
      };
      rebase = {
        autosquash = true;
      };
      help = {
        autocorrect = "prompt";
      };
      branch = {
        sort = "-committerdate";
      };
      status = {
        submodulesummary = true;
      };
    };
    includes = [
      {
        condition = "gitdir:~/work/";
        contents = {
          user = {
            email = "venberggabe@johndeere.com";
          };
        };
      }
    ];
  };
  programs.lazygit.enable = true;

  programs.yazi = {
    enable = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
    settings = {
      format = lib.concatStrings [
        "[](color_orange)"
        "$shell"
        "$hostname"
        "[@](bg:color_orange)"
        "$username"
        "[ ](bg:color_orange)"
        "[](bg:color_yellow fg:color_orange)"
        "$directory"
        "[](fg:color_yellow bg:color_aqua)"
        "$git_branch"
        "$git_status"
        "[](fg:color_aqua bg:color_blue)"
        "$git_metrics"
        "[](fg:color_blue bg:color_bg3)"
        "$git_commit"
        "$fill"
        "[](fg:color_bg1 bg:color_bg3)"
        "$time"
        "[ ](fg:color_bg1)"
        "$line_break"
        "$character"
      ];
      add_newline = false;
      palette = "gruvbox_dark";
      palettes.gruvbox_dark = {
        color_fg0 = "#fbf1c7";
        color_bg1 = "#3c3836";
        color_bg3 = "#665c54";
        color_blue = "#458588";
        color_aqua = "#689d6a";
        color_green = "#98971a";
        color_orange = "#d65d0e";
        color_purple = "#b16286";
        color_red = "#cc241d";
        color_yellow = "#d79921";
      };
      hostname = {
        ssh_only = false;
        format = "[$ssh_symbol$hostname]($style)";
        style = "bg:color_orange";
      };
      shell = {
        disabled = false;
        bash_indicator = "$";
        fish_indicator = "<><";
        zsh_indicator = "%";
        nu_indicator = ">";
        format = "[$indicator ]($style)";
        style = "bg:color_orange";
      };
      fill = {
        symbol = " ";
        style = "bg:color_bg3";
      };
      username = {
        show_always = true;
        style_user = "bg:color_orange fg:color_fg0";
        style_root = "bg:color_orange fg:color_fg0";
        format = "[$user]($style)";
      };
      directory = {
        style = "fg:color_fg0 bg:color_yellow";
        format = "[ $path ]($style)";
        fish_style_pwd_dir_length = 3;
        truncation_length = 4;
        truncation_symbol = "…/";
      };
      git_branch = {
        symbol = "";
        style = "bg:color_aqua";
        format = "[[ $symbol $branch ](fg:color_fg0 bg:color_aqua)]($style)";
      };
      git_status = {
        style = "bg:color_aqua";
        format = "[[($all_status$ahead_behind )](fg:color_fg0 bg:color_aqua)]($style)";
      };
      git_metrics = {
        disabled = false;
        added_style = "bg:color_blue fg:bold green";
        deleted_style = "bg:color_blue fg:bold red";
        format = "([ +$added ]($added_style))([-$deleted ]($deleted_style))";
      };
      git_commit = {
        only_detached = false;
        tag_disabled = false;
        format = "[($hash$tag)]($style)";
        style = "bg:color_bg3";
      };
      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:color_bg1";
        format = "[[  $time ](fg:color_fg0 bg:color_bg1)]($style)";
      };
      line_break.disabled = false;
      character.disabled = false;
    };
  };

  programs.nushell = {
    enable = true;
    configFile.source = lib.path.append dotfilesDirectory "nushell/config.nu";
    envFile.source = lib.path.append dotfilesDirectory "nushell/env.nu";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    history = {
      ignoreAllDups = true;
      extended = true;
    };
    shellAliases = {
      ll = "ls -lh";
      la = "-lha";
      please = "sudo $(fc -ln -1)";
      slideshow = "feh --full-screen --randomize --auto-zoom --recursive --slideshow-delay";
      pyactivate = "source ./.venv/bin/activate";
    };
    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "main"
        "brackets"
        "pattern"
        "regexp"
        "cursor"
        "root"
        "line"
      ];
    };
  };

  services.ssh-agent.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
