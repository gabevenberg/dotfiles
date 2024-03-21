{
  configs,
  pkgs,
  ...
}: {
  programs.nixvim = {
    keymaps = [
      {
        action = ":AerialToggle!<CR>";
        key = "<leader>o";
        mode = "n";
        options = {
          silent = true;
          desc = "toggle outline";
        };
      }
    ];
    extraPlugins = with pkgs.vimPlugins; [
      aerial-nvim
    ];
    extraConfigLua = ''require("aerial").setup({})'';
  };
}
