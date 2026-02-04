{ pkgs, lib, ... }:

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

  # Enable grayjay as unfree package
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "grayjay" ];
}
