{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wl-clipboard
    moonlight-qt
    hyprshot
    ripdrag
    gpu-screen-recorder
    freetube
  ];
}
