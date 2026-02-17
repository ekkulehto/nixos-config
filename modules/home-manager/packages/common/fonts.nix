{ pkgs, ... }:

{
  home.packages = with pkgs; [
    jetbrains-mono
    fira-code
    iosevka
    hack-font
    source-code-pro
    inter
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only 
  ];

  fonts.fontconfig.enable = true;
}
