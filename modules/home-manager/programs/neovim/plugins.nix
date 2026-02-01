{ pkgs, ... };

{
  plugins = with pkgs.vimPlugins; [
    nvim-autopairs   
  ];
}
