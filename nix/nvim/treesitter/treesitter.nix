{
  configs,
  pkgs,
  ...
}: {
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;
      folding = true;
      indent = true;
      nixvimInjections = true;
    };
    plugins.treesitter-context.enable = true;
    plugins.indent-blankline.enable = true;
    extraPlugins = [
      pkgs.vimPlugins.treesj
    ];
  };
  imports = [
    ./rainbow-delimiters.nix
  ];
}
