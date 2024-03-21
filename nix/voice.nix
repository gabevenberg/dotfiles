{
  config,
  pkgs,
  ...
}: {
  home.shellAliases = {
    say = "espeak -p 10 -s 150 -a 200";
  };
  home.packages = with pkgs; [
    espeak
  ];
}
