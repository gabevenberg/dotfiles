{
  config,
  pkgs,
  lib,
  ...
}: {
  #sessionVariables, sessionPath and shellAliases are not applied to nushell.
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
  };

  home.file = {
    ".config/nushell/scripts".source = ./scripts;
  };

  programs.yazi.enableNushellIntegration = true;
  programs.zoxide.enableNushellIntegration = true;
  programs.starship.enableNushellIntegration = true;
}