{
  configs,
  pkgs,
  ...
}: {
  programs.nixvim = {
  };
  imports = [
    # ./outline.nix
  ];
}
