{ pkgs, ... }:

{
  home.packages = with pkgs; [
    jetbrains-mono
    fira-code
    iosevka
    hack-font
    source-code-pro
  ];

  fonts.fontconfig.enable = true;
}
