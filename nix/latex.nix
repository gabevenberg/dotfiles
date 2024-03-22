{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    texliveMedium
  ];
  home.file = {
    ".latexmkrc".text = ''
      $dvi_previewer = 'xdvi -watchfile 1.5';
      $ps_previewer  = 'zathura';
      $pdf_previewer = 'zathura';
    '';
  };
  home.shellAliases = {
    pdfmk = "latexmk -lualatex -pvc";
  };
}
