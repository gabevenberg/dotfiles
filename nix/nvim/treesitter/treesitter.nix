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
    extraPlugins = with pkgs.vimPlugins; [
      treesj
    ];
    extraConfigLua = ''require("treesj").setup({})'';
  };
  imports = [
    ./rainbow-delimiters.nix
    ./arial.nix
  ];
}
