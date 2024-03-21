{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    texliveMedium
  ];
  home.shellAliases = {
    pdfmk = "latexmk -lualatex -pvc";
  };
}
