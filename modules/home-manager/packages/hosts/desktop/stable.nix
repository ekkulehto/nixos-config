{ pkgs, ... }:

{
  home.packages = with pkgs; [
    moonlight-qt
    hyprshot
    ripdrag
    gpu-screen-recorder
    freetube
  ];
}
