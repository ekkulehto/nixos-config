{ pkgs, noctalia, ... }:

{
  home.packages = with pkgs; [
    wl-clipboard
    moonlight-qt
    hyprshot
    ripdrag
    gpu-screen-recorder
    freetube
    noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
