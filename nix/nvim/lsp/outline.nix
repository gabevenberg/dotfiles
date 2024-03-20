{
  configs,
  pkgs,
  ...
}: {
  programs.nixvim = {
    keymaps = [
      {
        action = ":Outline<CR>";
        key = "<leader>o";
        mode = "n";
        options = {
          silent = true;
          desc = "toggle outline";
        };
      }
    ];
    extraPlugins = [
      pkgs.vimPlugins.outline-nvim
    ];
  };
}
