{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wl-clipboard
    ripgrep
    moonlight-qt
    ddcutil
    edid-decode
  ];
}
