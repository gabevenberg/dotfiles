{
  config,
  pkgs,
  helpers,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "gabe";
  home.homeDirectory = "/home/gabe";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    zellij
    sshfs
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/zellij/config.kdl".source = ./zellij/config.kdl;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.sessionPath = [
    "$HOME/.nix-profile/bin/"
    "$HOME/.local/bin/"
    "$HOME/.cargo/bin/"
    "/opt/"
  ];

  home.shellAliases = {
    say = "espeak -p 10 -s 150 -a 200";
    tmux = "tmux -u";
    pdfmk = "latexmk -lualatex -pvc";
    doc2pdf = "loffice --convert-to-pdf --headless *.docx";
    sshmnt = "sshfs -o idmap=user,compression=no,reconnect,follow_symlinks,dir_cache=yes,ServerAliveInterval=15";
  };

  imports = [
    ./nushell/nushell.nix
    ./zsh.nix
    ./git.nix
    ./starship.nix
    ./nvim/nvim.nix
  ];

  programs.yazi.enable = true;

  programs.zoxide.enable = true;

  programs.fzf.enable = true;

  services.ssh-agent.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # enable flakes
  nix = {
    package = pkgs.nix;
    settings.experimental-features = ["nix-command" "flakes"];
  };
}
