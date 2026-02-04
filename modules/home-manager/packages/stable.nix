{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wl-clipboard
    ripgrep
    moonlight-qt
    quickshell
    yazi
    hyprshot
    gpu-screen-recorder
    freetube
    grayjay
  ];
}
