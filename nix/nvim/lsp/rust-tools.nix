{
  configs,
  pkgs,
  ...
}: {
  programs.nixvim = {
    plugins.rust-tools = {
      enable = true;
    };
  };
}
