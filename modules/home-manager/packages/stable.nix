{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wl-clipboard
    ripgrep
    moonlight-qt
    quickshell
    hyprshot
    gpu-screen-recorder
    freetube
  ];
}
