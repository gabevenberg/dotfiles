{
  configs,
  pkgs,
  ...
}: {
  programs.nixvim = {
    plugins.rainbow-delimiters = {
      enable = true;
      highlight = [
        "RainbowDelimiterYellow"
        "RainbowDelimiterBlue"
        "RainbowDelimiterOrange"
        "RainbowDelimiterGreen"
        "RainbowDelimiterViolet"
        "RainbowDelimiterCyan"
        # "RainbowDelimiterRed"
      ];
    };
  };
}
