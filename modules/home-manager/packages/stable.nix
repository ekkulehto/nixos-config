{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wl-clipboard
    ripgrep
    moonlight-qt
    hyprshot
    gpu-screen-recorder
    freetube
    ripdrag
    fastfetch
  ];
}
