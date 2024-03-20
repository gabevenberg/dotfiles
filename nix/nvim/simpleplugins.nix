{
  configs,
  pkgs,
  ...
}: {
  programs.nixvim = {
    plugins.comment-nvim.enable = true;
    plugins.marks.enable = true;
    plugins.surround.enable = true;
    plugins.todo-comments.enable = true;
    plugins.leap = {
      enable = true;
      addDefaultMappings = true;
    };
    extraPlugins = [
      pkgs.vimPlugins.vim-numbertoggle
    ];
  };
}
